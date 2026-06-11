@echo off

REM Create directories. Most ship tracked (via .gitkeep); mkdir of an existing
REM folder is harmless here, errors are suppressed with 2>nul.
mkdir data\intermediate\restricted 2>nul
mkdir data\final\restricted 2>nul
mkdir output\figures\appendix 2>nul
mkdir output\tables\appendix 2>nul
mkdir tmp\restricted 2>nul
mkdir sandbox 2>nul

REM Make sure CLAUDE.md points at AGENTS.md (single source of agent rules).
REM Git may check the symlink out as a plain text file on Windows, so replace it
REM with a hard link (mklink /H needs no admin rights).
if exist CLAUDE.md del CLAUDE.md
mklink /H CLAUDE.md AGENTS.md
