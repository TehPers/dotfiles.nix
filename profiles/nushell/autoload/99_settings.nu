# General configuration
$env.config.show_banner = false
$env.config.completions.quick = false
$env.config.completions.partial = false
$env.config.history.file_format = "sqlite"
$env.config.history.isolation = true
$env.config.table.mode = "compact"
$env.config.filesize.unit = "metric"

$env.EDITOR = "code"
$env.GIT_EDITOR = "code -w"
$env.VIRTUAL_ENV_DISABLE_PROMPT = true # starship shows current venv already

# Enable autoenv
use dotenv.nu *
dotenv autoenv enable -r
