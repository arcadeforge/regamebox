#include "SDL/SDL.h"
#include "SDL/SDL_ttf.h"
#include "SDL/SDL_image.h"
#include "stdio.h"

int main(int argc, char* argv[])
{
    char text[255] = "\0";
    strcpy(text, argv[1]);

    printf("Init\n");
    SDL_Surface *screen = NULL;
    //SDL_Renderer *renderer = NULL;

    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        printf("SDL_Init failed - %s\n", SDL_GetError());
        return 1;
    }

    SDL_ShowCursor(SDL_DISABLE);

    screen = SDL_SetVideoMode(320, 240, 24, SDL_FULLSCREEN);

    // init the font engine
    if (TTF_Init()) {
        printf("TTF_Init failed - %s\n", SDL_GetError());

        SDL_Quit();
        return 1;
    }


    if (!screen)
    {
        printf("SetVideoMode failed - %s\n", SDL_GetError());
        SDL_FreeSurface(screen);
        SDL_Quit();
        return 1;
    }



	//Render text
	SDL_Color textColor = { 255, 233, 0 };

    //TTF_RenderText_Blended  
    TTF_Font *gFont = TTF_OpenFont("murphy.ttf", 40);
    if (!gFont) 
    {
        printf("Font failed - %s\n", SDL_GetError());
        SDL_FreeSurface(screen);
        SDL_Quit();
        return 1;

    }

    printf ("Font created\n");

    SDL_Surface* textSurface;
	textSurface = TTF_RenderText_Blended( gFont, text, textColor );

	if( textSurface == NULL )
	{
    	printf( "Unable to render text surface! SDL_ttf Error: %s\n", TTF_GetError() );
	}
	else
	{

        printf ("textsurface created");
		//Create texture from surface pixels
        //SDL_Texture mTexture = SDL_CreateTextureFromSurface( renderer, textSurface );
		//if( mTexture == NULL )
		//{
		//	printf( "Unable to create texture from rendered text! SDL Error: %s\n", SDL_GetError() );
		//}
		//else
		//{
		//	//Get image dimensions
		//	int mWidth = textSurface->w;
		//	int mHeight = textSurface->h;
		//}
		//Get rid of old surface
		//SDL_FreeSurface( textSurface );
	}


    SDL_Rect title_rect;
    title_rect.x = 100; 
    title_rect.y = 100;
    title_rect.w = 320;
    title_rect.h = 240;
    
   
   SDL_Surface* _buffer;
   
   _buffer = SDL_CreateRGBSurface(SDL_SWSURFACE,
      320, 240, 32, // w,h,bpp
      0x000000ff, 0x0000ff00, 0x00ff0000, 0x00000000); // rgba masks, for big-endian

   // draw title to back buffer
   SDL_BlitSurface(textSurface, NULL, _buffer, &title_rect);


   //SDL_FillRect(screen, NULL, SDL_MapRGB(_buffer->format, 255, 0, 0));
   //SDL_FillRect(_buffer, &title_rect, SDL_MapRGB(_buffer->format, 255, 0, 0));
   SDL_BlitSurface(_buffer, NULL, screen, NULL);
    

    //SDL_BlitSurface(_buffer, NULL, screen, &title_rect);
    SDL_Flip(screen);
    SDL_Delay(2000);
    SDL_FreeSurface( textSurface );

    //SDL_FreeSurface(image);
    TTF_CloseFont(gFont); // free fonts

    SDL_Quit();

    return 0;

}

