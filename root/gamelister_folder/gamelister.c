/* 
 * Program Argument is the game list for lr-fbalpha. Nur Spiele, die sich auf diese Liste befinden
 * werden in die games.conf für lemonlauncher übernommen
 * 
 * Ausgabe ist die Datei games.conf_part
 * Ausgabe für ADVMAME ist die Datei advmame_games.conf
 * 
 * Funktionsweise
 * Alle Verzeichnisse unter dem Verzeichnis roms werden durchgegangen und alle Dateien als Spiele angenommen
 * 
 * Beispiel roms/advmame/dkong.zip
 * 
 * Dann ist der Emulator advmame und das rom dkong.zip
 * 
 * Die roms werden in Semikolons eingepackt, damit im autostart die roms besser vom emulator im ll_result.txt getrennt werden können
 * 
 * Die Titel werden gleich dem Rom Namen gesetzt. Das ist für die Konsolen Emulatoren in Ordnung. 
 * 
 * Für die Arcade Emulatoren aber nicht. Für lr-fbalpha wird an Hand der Datei lr-fbalpha.csv die Titel über die rom Namen gesucht. 
 * Die csv Datei wird in ein Array gepackt.
 * 
 * Beispiel: Rom Name dkong.zip gefunden:
 * 
 * Dann wird im Array über dkong.zip der Titel Donkey Kong gefunden.
 * 
 * Leere Folder werden nicht mehr in games.conf übernommen.
 * 
 * Vor dem Release für Linux muss der Zeilenende Trenner von \n auf \r gesetzt werden. Suche nach Linux
 *
 * 
 *  Beispiel Ausführung
 * 
 * gamelister lr_fbalpha.csv advmame.csv roms/
 * 
 * TODO
 * 
 * - Filter für Cabs : H, V, Anzahl Buttons, Anzahl Sticks etc
 * 
 * */
 
#include <sys/types.h>
#include <dirent.h>
#include <string.h>

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

//diff between console and arcade because vertical screen
FILE *console_games;
FILE *arcade_games;
//FILE *not_found;

int system(const char *command);

struct dirent *dirzeiger;

char fba_csv[255] = "\0";
char mame_csv[255] = "\0";

struct game {
    char rom[255];
    char title[255];
    char orient[255];
};


struct game gListMame[5080];
struct game gListFBA[4400];

int maxFba = 0;
int maxMame = 0;

int main(int argc, char **argv)
{

    DIR *dir;
    char strRomDir[255] = "\0";
    char strRomDirM4all [255] = "\0";
    char strRomDirPiFBA[255] = "\0";
    
    //printf("Filterdatei fuer lr-fbalpha : %s\n", argv[1]); 
    strcpy(fba_csv, argv[1]);
    strcpy(mame_csv, argv[2]);
    
    strcpy(strRomDir, argv[3]);
    
    //strcat(strRomDir, "\\roms\\");
    //Linux
    strcat(strRomDir, "/roms/");
    
    console_games = fopen ("console_games.conf", "w"); 
    arcade_games = fopen ("arcade_games.conf", "w"); 
    //not_found = fopen ("not_found.txt", "w"); 

    //baue Array für die Suche nach Titel
    //Sonderbehandlung m4all
    //Sonderbehandlung piFBA
    maxMame = buildGameFilterArray (mame_csv, gListMame);
    maxFba = buildGameFilterArray (fba_csv, gListFBA);
   
    if((dir=opendir(strRomDir)) == NULL)
    {
        printf("\nFehler beim oeffnen des Verzeichnisses: %s " , strRomDir);
        return 1;
    }
    else
    {
        //printf("\nVerzeichnis  : %s " , strRomDir);
        //readdir(dir);
        //readdir(dir);
        while((dirzeiger=readdir(dir)) != NULL)
        {
            readGames(strRomDir, dirzeiger->d_name);
        }
    }
    closedir(dir);
    fclose (console_games);
    fclose (arcade_games);
    //fclose (not_found);
    return 0;
}

int buildGameFilterArray(char game_list[], struct game gList[]) {

    
    int i=0;
    int max_fba_games=0;
    
    char title_fba[255] = "\0";
    char rom_fba[255] = "\0";    
    char orient_fba[255] = "\0";      
    
    char *ptr;    
    
    FILE *fGamelist;

    fGamelist=fopen(game_list, "r");
    char puffer[255];
  
    if(NULL == fGamelist) 
    {
        fprintf(stderr, "Fehler beim Oeffnen ...\n");
        return 0;
    }


    
    while(fgets(puffer,255,fGamelist)) 
    {
        if(strrchr(puffer, ';') != 0)
        {
            //Zeilenumbruch raus
            //printf("\npuffer %s", puffer);
            
            //ptr = strrchr(puffer, '\r');
            //Use N for win
            ptr = strrchr(puffer, '\n');

            *ptr = '\0';


           //Orientation
            ptr = strrchr(puffer, ';')+1;
            strcpy(orient_fba,ptr);    
            //printf("Orient: *%s*\n", orient_fba);


            //Titel Name            
            //; raus aus Titel
            //suche position vom ; und gehe auf das nächste Zeichen über Pointer
            ptr = strchr(puffer, ';')+1;
            strcpy(title_fba,ptr);
            ptr = strchr(title_fba, ';');
            *ptr = '\0';
            
            //printf("Titel : *%s*\n", title_fba);

             //Rom Name
            // Suche ; als Ende des Puffers und schneide ab
            // und kopiere den Puffer vom Anfang bis zum ;
            ptr = strchr(puffer, ';');
            *ptr = '\0';
            strcpy(rom_fba,puffer);
                        
            //printf("\nRom : *%s*\n", rom_fba);

            //baue array
            strcpy(gList[i].rom, rom_fba);
            strcpy(gList[i].title, title_fba);
            strcpy(gList[i].orient, orient_fba);
            //if (strcmp("donpachi", rom_fba) == 0) 
            //{
            //  printf("\nRom : *%s*\n", &gList[i].rom);
            //  printf("Titel : *%s*\n", &gList[i].title);
            //  printf("Orient: *%s*\n", &gList[i].orient);
            //}
            // getchar();
            i++;
        }
    }


    max_fba_games = i - 1;
    //printf("\n%d Spiele gefunden.\n", max_fba_games);
    //printf("Letzter Titel : *%s*\n", &gList[max_fba_games].title);
    return max_fba_games;
}

int writeGameUseFilter (char strSubDir[], char title[], int max_games, struct game gList[])
{
    int i=0;
    char rom[255] = "\0";  
    //printf("Titel : *%s*\n", title);
    
    while(i <= max_games )
    {
        // falls in Liste, dann in die games.conf übernehmen       
        // title und rom Vergleich, da title die Dateiendung nicht enthält

        if (strcmp(title, gList[i].rom) == 0)
        {

            fprintf (arcade_games, "\ngame { rom = \"%s" , gList[i].rom);
            fprintf (arcade_games, "\" title = \"%s" , gList[i].title);
            fprintf (arcade_games, "\" params = \";%s\" ", strSubDir);  
            if (strcmp("a", gList[i].orient) == 0) 
                 fprintf (arcade_games, "orientation = %s", gList[i].orient); 
            fprintf (arcade_games, "}", strSubDir); 

            //printf("Titel_FOUND : *%s*\n", gList[i].title);
            return;

        } else {
            //game not found
           
        }
        i++;
    }
    //fprintf (not_found, "\n %s" , title);
    //printf("Titel_NOT_FOUND : *%s*\n", title);
      
}

//returns 0 if not
int EndsWith(const char *str, const char *suffix)
{
    if (!str || !suffix)
        return 0;
    size_t lenstr = strlen(str);
    size_t lensuffix = strlen(suffix);
    if (lensuffix >  lenstr)
        return 0;
    return strncmp(str + lenstr - lensuffix, suffix, lensuffix) == 0;
}

int readGames(char strRomDir[], char strSubDir[]) {
    
    if (strcmp(strSubDir, ".") == 0 ||
        strcmp(strSubDir, "..") == 0 )
    {
        //printf(" dont process . or .."); 
    } else {
 

    DIR *dir;
    char title[255] = "\0";
    char rom[255] = "\0";    
    char *ptr;
    char path[255] = "\0";
    
    //printf("\nstrRomDir: %s", strRomDir);
    //printf("\nstrSubDir: %s", strSubDir);
     
    strcat(path, strRomDir);
    strcat(path,strSubDir);
    //printf("\npath: %s", path);
    
    int max_games=0;
    int boolShowMenu=0;
        
    // Baue games.conf_part
    // hier werden die Rom Listen gebaut
    
    if((dir=opendir(path)) == NULL)
    {
        printf("\n1: Fehler beim Oeffnen des SubVerzeichnisses: %s " , path);
        return 1;
    }
    else
    {
        //printf("\nOeffnen des Verzeichnisses: %s", path);
        //. und .. überlesen
        //readdir(dir);
        //readdir(dir);
        if (strcmp(strSubDir, ".") == 0 ||
            strcmp(strSubDir, "..") == 0 )
        {
        //printf(" dont process . or .."); 
        } else {

        
        // komplettes Verzeichnis Eintrag fuer Eintrag auslesen 
        while((dirzeiger=readdir(dir)) != NULL)
        {
            //Spielsystem nur aufführen, wenn mind. ein Spiel vorhanden ist.
            //Alle Spiele schreiben
            strcpy(rom,(*dirzeiger).d_name);
            strcpy(title,(*dirzeiger).d_name); 
            
            //Falls Ende rom nirgendwas mit state oder so ist, dann ist es 
            // eine temporär angelegte Datei und kein Spiel
            
            if (EndsWith(rom, ".state") == 0) {
                        
                //Dateiendung aus Titel raus
                if(strrchr(title, '.') != 0)
                {
                    ptr = strrchr(title, '.');
                    *ptr = '\0';
                }
                
                // Es sollen nur die lf-fbalpha Spiele aus der Liste angezeigt werden.
                // Sonst alle.
                if (strcmp(strSubDir, "lr-fbalpha") == 0 || 
                    strcmp(strSubDir, "neogeo") == 0 ||
                    strcmp(strSubDir, "pifba") == 0 )
                {
                    if (boolShowMenu==0)
                    {
                        boolShowMenu = 1;
                        fprintf (arcade_games, "\nmenu \"%s\" {" , strSubDir);
                    }
                    writeGameUseFilter(strSubDir, title, maxFba, gListFBA);
                } 
                else if (strcmp(strSubDir, "advmame") == 0 || 
                    strcmp(strSubDir, "mame2003") == 0 ||
                    strcmp(strSubDir, "neogeo") == 0 ||
                    strcmp(strSubDir, "arcade") == 0 ||
                    strcmp(strSubDir, "mame2003plus") == 0 ||
                    strcmp(strSubDir, "m4all") == 0 ||
                    strcmp(strSubDir, "mame2010") == 0 ||
                    strcmp(strSubDir, "mame2000") == 0 ||
                    strcmp(strSubDir, "lr-fbalpha") == 0 || 
                    strcmp(strSubDir, "pifba") == 0 ) 
                
                {
                    if (boolShowMenu==0)
                    {
                        boolShowMenu = 1;
                        fprintf (arcade_games, "\nmenu \"%s\" {" , strSubDir);
                    }
                    writeGameUseFilter(strSubDir, title, maxMame, gListMame);
                } 
                else
                {
                   
                    //die Semikolons sind eine Hilfe für das Autostart.sh Skript
                    if (boolShowMenu==0)
                    {
                        boolShowMenu = 1;
                        //printf ("\nmenu %s", strSubDir);
                        fprintf (console_games, "\nmenu \"%s\" {" , strSubDir);
                    }
		    if (strcmp(rom, ".") == 0 ||
            		strcmp(rom, "..") == 0 )
        	    {
                       //again dont proess . or ..
		    } 
	     	    else
		    {
                        fprintf (console_games, "\ngame { rom = \"%s" , rom);
                        fprintf (console_games, "\" title = \"%s" , title);
                        fprintf (console_games, "\" params = \";%s\" }", strSubDir);
		    }  
                }
            }

        }}
        if (boolShowMenu == 1)
        {
            //es wurde mind. 1 Spiel gefunden, also ein Systemmenü geschrieben
            //Klammer zu
            if (strcmp(strSubDir, "advmame") == 0 || 
                    strcmp(strSubDir, "mame2003") == 0 ||
                    strcmp(strSubDir, "arcade") == 0 ||
                    strcmp(strSubDir, "neogeo") == 0 ||
                    strcmp(strSubDir, "mame2003plus") == 0 ||
                    strcmp(strSubDir, "m4all") == 0 ||
                    strcmp(strSubDir, "mame2010") == 0 ||
                    strcmp(strSubDir, "mame2000") == 0 ||
                    strcmp(strSubDir, "lr-fbalpha") == 0 || 
                    strcmp(strSubDir, "pifba") == 0 ) {
                fprintf (arcade_games, "\n}");
            }
            else {
		fprintf (console_games, "\n}");
                //printf ("\nmenu close %s", strSubDir);
            }
        }

        boolShowMenu = 0;

    }
    return 0;
}
}
