// https://wiki.libsdl.org/SDL3/SDL_CreateRenderer
//
//
//
//
//
const std = @import("std");

const c = @cImport({
    @cInclude("SDL3/SDL.h");
});

// pub fn main() !void {
//     std.debug.print("Hello, World!\n", .{});
// }

pub fn main() !void {
    _ = c.SDL_Init(c.SDL_INIT_VIDEO);
    defer c.SDL_Quit();

    const window = c.SDL_CreateWindow("hello gamedev", 640, 400, c.SDL_WINDOW_OPENGL);
    //const window = c.SDL_CreateWindow("hello gamedev", 640, 400, 0);
    defer c.SDL_DestroyWindow(window);
    std.debug.print("\n opengl {any}\n", .{c.SDL_WINDOW_OPENGL});

    //const renderer = c.SDL_CreateRenderer(window, 0, c.SDL_RENDERER_PRESENTVSYNC);
    //const renderer = c.SDL_CreateRenderer(window, 0, 0);
    const renderer = c.SDL_CreateRenderer(window, null, 0);
    defer c.SDL_DestroyRenderer(renderer);

    mainloop: while (true) {
        var sdl_event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&sdl_event) != 0) {
            switch (sdl_event.type) {
                c.SDL_EVENT_QUIT => break :mainloop,
                else => {},
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0xff, 0xff, 0xff);
        _ = c.SDL_RenderClear(renderer);
        //var rect = c.SDL_Rect{ .x = 0, .y = 0, .w = 60, .h = 60 };
        var rect = c.SDL_FRect{ .x = 0, .y = 0, .w = 60, .h = 60 };
        const tick = @as(f32, @floatFromInt(c.SDL_GetTicks()));

        const a = 0.001 * tick;

        const t = 2 * std.math.pi / 3.0;
        const r = 100 * @cos(0.1 * a);

        rect.x = 290 + r * @cos(a);
        rect.y = 170 + r * @sin(a);
        _ = c.SDL_SetRenderDrawColor(renderer, 0xff, 0, 0, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        rect.x = 290 + r * @cos(a + t);
        rect.y = 170 + r * @sin(a + t);
        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0xff, 0, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        rect.x = 290 + r * @cos(a + 2 * t);
        rect.y = 170 + r * @sin(a + 2 * t);
        _ = c.SDL_SetRenderDrawColor(renderer, 0, 0, 0xff, 0xff);
        _ = c.SDL_RenderFillRect(renderer, &rect);
        _ = c.SDL_RenderPresent(renderer);
    }

    //
}
