# Learn Perl 

## Requirements

[Install plenv](https://github.com/tokuhirom/plenv#installation)


## Install requirements 

```shell
# Install perl version

plenv install 5.36.0 #The version can be of your choice.

# Install cpanm 

plenv install-cpanm

# Install Carton

cpanm Carton 

# Run this command after install cpan module, contains executable script.
plenv rehash

```

## Install libs locally

```shell
# On your development environment create a cpanfile and put your requirementes like this
cat cpanfile
requires 'Text::CSV';

# Install your requirements
carton install
```


This will create a `local` folder in your project with all its dependencies so that the interpreter recognizes this folder you need to set the PERL5LIB environment variable with the path to the folder.

```shell
export PERL5LIB=local/lib/perl5
```


