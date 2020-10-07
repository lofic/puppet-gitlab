class gitlab::cli {

    # gitlab rubygem
    package { 'gitlab':
        provider => 'gem'
    }

}
