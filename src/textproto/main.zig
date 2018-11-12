const std = @import("std");
const mem = std.mem;

pub const TextProto = struct.{
    /// A MIMEHeader represents a MIME-style header mapping
    /// keys to sets of values
    pub const MIMEHeader = struct.{
        header: std.HashMap([]const u8, [][]const u8, mem.hash_slice_u8, mem.eql_slice_u8),
    };
};
