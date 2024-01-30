::Remove directory and recreate it
set "dstDir=I:\My Drive\Designer\Program\Thrawn\bin"

::Copy specific from this directory to destination
xcopy   ".\target\net.clojars.SSM\*.jar" "%dstDir%"  /y



