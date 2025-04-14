# Replication files for ...

## Folder structure

This diagram shows the full directory structure after calling setup.sh on Linux or setup_win.bat on Windows so far, some folders (data and tmp) are not synced on GitHub, see invisible .gitignore file: 

    .
    ├── code
    │   ├── analyze
    │   ├── build
    │   └── put_master_here
    ├── data
    │   ├── intermediate
    │   └── output
    ├── output
    │   ├── figures
    │   │   └── appendix
    │   └── tables
    │       └── appendix
    ├── README.md
    ├── setup.sh
    ├── setup_win.bat
    └── tmp

    13 directories, 4 files


All the input data should be in the Dropbox or shared folder under `/../data/input` and should be separated by  `/../data/input/restricted` and `/../data/input/public`.
