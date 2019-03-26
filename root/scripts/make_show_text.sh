gcc -o show_text -lSDL_ttf -lSDL_gfx -lSDL_image -lstdc++  -L/tmp/sdl/lib -Wl,-rpath,/tmp/sdl/lib -lSDL show_text.c
