@echo off

REM Create directories
mkdir data
mkdir data\intermediate
mkdir data\intermediate\restricted
mkdir data\final
mkdir data\final\restricted
mkdir output
mkdir output\figures
mkdir output\tables
mkdir output\figures\appendix
mkdir output\tables\appendix
mkdir tmp
mkdir tmp\restricted
mkdir sandbox

REM Make sure CLAUDE.md points at AGENTS.md (single source of agent rules).
REM Git may check the symlink out as a plain text file on Windows, so replace it
REM with a hard link (mklink /H needs no admin rights).
if exist CLAUDE.md del CLAUDE.md
mklink /H CLAUDE.md AGENTS.md
