const std = @import("std");

pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();

        items: std.ArrayList(T),

        pub fn init(gpa: std.mem.Allocator) Self {
            return Self {
                .items = std.ArrayList(T).init(gpa),
            };
        }

        pub fn deinit(self: Self) void { self.items.deinit(); }

        pub fn peek(self: Self) ?T {
            return if (self.items.items.len == 0) null else self.items.items[0];
        }

        pub fn enque(self: *Self, item: T) void { self.items.append(item) catch unreachable; }

        pub fn deque(self: *Self) ?T {
            return if (self.items.items.len == 0) null else self.items.orderedRemove(0);
        }

        pub fn deque_at(self: *Self, index: usize) ?T {
            return if (self.items.items.len == 0) null else self.items.orderedRemove(index);
        }

        pub fn iter(self: Self) []T { return self.items.items; }

        pub fn len(self: Self) usize { return self.items.items.len; }
    };
}
