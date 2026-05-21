# Clone dotenv.nu repository if needed (and possible)
if ($NU_LIB_DIRS | is-not-empty) {
    let repo_dir = $NU_LIB_DIRS | get 0 | path join "dotenv.nu"
    if not ($repo_dir | path exists) {
        git clone "https://github.com/TehPers/dotenv.nu.git" $repo_dir --depth 1
    } else {
        do {
            cd $repo_dir
            job spawn {
                try {
                    git fetch --depth 1
                    git pull --depth 1
                }
            } | ignore
        }
    }
}
