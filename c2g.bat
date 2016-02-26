@echo off
set input=0
set lod=0
set type=0
set output=0
call :args %*
if -%input%-==-0- goto usage
if -%lod%-==-0- goto usage
if -%type%-==-0- goto usage
if -%output%-==-0- goto usage
java -jar c2x.jar -f COLLADA -i %input% -t %type% -l %lod% -o %output%.dae
collada2gltf -f %output%.dae -o %output%
goto exit
:args
if -%1%-==-- goto endargs
if -%1%-==---input- (
    if not exist %2% (
        echo Exit: Input file does not exist
    )
    set input=%2
) else if -%1%-==---lod- (
    if -%2%-==-LOD1- (
        set lod=%2
    ) else (
        if -%2%-==-LOD2- (
            set lod=%2
        ) else (
            echo Exit: Unknown level of detail
        )
    )
) else if -%1%-==---type- (
    if -%2%-==-SOLID- (
        set type=%2
    ) else (
        if -%2%-==-MULTI_SURFACE- (
            set type=%2
        ) else (
            echo Exit: Unknown geometry type %2%
        )
    )
) else if -%1%-==---output- (
    if -%2%-==-- (
        echo Exit: Missing output file prefix
    ) else (
        set output=%2
    )
)
shift
shift
goto args
:endargs
exit /b
:usage
echo Usage: c2g --input file --output prefix --lod [LOD1^|LOD2] --type [SOLID^|MULTI_SURFACE]
:exit