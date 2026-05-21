# Prettier, more human friendly ls. Lists the files in a directory with icons.
export def ll [
  pattern: glob = "." # The glob pattern to use.
]: nothing -> table {
  let files = ls -al $pattern | sort-by type name -i
  let names = $files
    | each { |it| $it | grid -ic | str trim -c "\n" }
    | wrap name
  $names | merge ($files | select type size modified)
}
