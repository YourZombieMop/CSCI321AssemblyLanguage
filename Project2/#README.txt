HOW TO COMPILE:
1.) Ensure GCC is installed and referencable by PATH.
Open Command prompt and run the following.

For a debug build:
cd /d "P:\Assembly\CSCI321AssemblyLanguage\Project2\" && g++ *.cpp -Wall -o build

For a debug build & run:
cd /d "P:\Assembly\CSCI321AssemblyLanguage\Project2\" && g++ *.cpp -Wall -o build && start cmd /C "P:\Assembly\CSCI321AssemblyLanguage\Project2\"build

For a release build:
cd /d "P:\Assembly\CSCI321AssemblyLanguage\Project2\" && g++ *.cpp -static-libgcc -static-libstdc++ -Wall -o build

For a release build & run:
cd /d "P:\Assembly\CSCI321AssemblyLanguage\Project2\" && g++ *.cpp -static-libgcc -static-libstdc++ -Wall -o build && start cmd /C "P:\Assembly\CSCI321AssemblyLanguage\Project2\"build