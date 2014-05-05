##IA - Nosotros

This is a simple ruby script used to upload video files and associated metadata to Internet Archive via its S3-like storage API. Requires the curb gem.

To run from command line:
```bash
ruby ia3-nosotros.rb programa-nosotros-metadata.json /path/to/files your-IA-accesskey your-IA-secret-code
```

Metadata for the videos is included as json and csv files.  There is also an Open Refine project file, which outlines the steps used to clean up the original metadata file. 

Videos are available in the [Nosotros TV collection](https://archive.org/details/nosotrostv) on Internet Archive.

For more details about the IA API, see [Internet Archive's documentation](https://github.com/vmbrasseur/IAS3API).

