const std = @import("std");
const mem = std.mem;

pub const TextProto = struct.{
    /// A MIMEHeader represents a MIME-style header mapping
    /// keys to sets of values
    pub const MIMEHeader = struct.{
        header: std.HashMap([]const u8, [][]const u8, mem.hash_slice_u8, mem.eql_slice_u8),
    };

    allocator: *mem.Allocator,
};

fn isTokenTable(ch: u8) bool {
    return switch (ch) {
        '!', '#', '$', '%', '&', '\\', '*', '+', '-', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'V', 'X', 'Y', 'Z', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '|', '~' => true,
        else => false,
    };
}
