//
const std = @import("std");

pub fn build(b: *std.Build) void {
    //
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "sdl_app",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const sdl_path = "lib\\sdl3\\";
    exe.addIncludePath(b.path(sdl_path ++ "include"));
    exe.addLibraryPath(b.path(sdl_path ++ "lib\\x64"));
    b.installBinFile(sdl_path ++ "lib\\x64\\SDL3.dll", "SDL3.dll");
    exe.linkSystemLibrary("SDL3");
    exe.linkLibC();

    //exe.linkLibC();
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
