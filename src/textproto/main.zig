const std = @import("std");
const mem = std.mem;

/// TextProto implements generic support for text-based request/response
/// protocols in the style of HTTP, NNTP, and SMTP.
///
/// The struct provides:
///
/// Error, which represents a numeric error response from
/// a server.
///
/// Pipeline, to manage pipelined requests and responses
/// in a client.
///
/// Reader, to read numeric response code lines,
/// key: value headers, lines wrapped with leading spaces
/// on continuation lines, and whole text blocks ending
/// with a dot on a line by itself.
///
/// Writer, to write dot-encoded text blocks.
///
/// Conn, a convenient packaging of Reader, Writer, and Pipeline for use
/// with a single network connection.
pub const TextProto = struct {
    /// A MIMEHeader represents a MIME-style header mapping
    /// keys to sets of values
    pub const MIMEHeader = struct {
        header: std.HashMap([]const u8, [][]const u8, mem.hash_slice_u8, mem.eql_slice_u8),
    };

    allocator: *mem.Allocator,
};

fn validHeaderFieldByte(b: u8) bool {
    return @intCast(usize, b) < token_table_size and isTokenTable(b);
}

const token_table_size: usize = 77;

fn isTokenTable(ch: u8) bool {
    return switch (ch) {
        '!', '#', '$', '%', '&', '\\', '*', '+', '-', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'V', 'X', 'Y', 'Z', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '|', '~' => true,
        else => false,
    };
}
