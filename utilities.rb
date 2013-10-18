def colorize(text, color_code); "\e[#{color_code}m#{text}\e[0m"; end
def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def yellow(text); colorize(text, 33); end
def magenta(text); colorize(text, 35); end
def cyan(text); colorize(text, 36); end
def comment(text); say yellow(text); end

def heading(text)
  say "\n"
  say cyan "#######################################"
  say cyan "## #{text}"
  say cyan "#######################################"
  say "\n"
end

def sub_heading(text)
  say "\n"
  say magenta "## #{text}"
  say "\n"
end

def recipe(filename); "#{repo_root}/recipes/#{filename}.rb"; end

def secret_key_base
  token = StringIO.new
  IO.popen("rake secret") do |pipe|
    pipe.each do |line|
      token.print(line.chomp)
    end
  end
  token.string
end

def copy_from_repo(filename, erb: false)
  begin
    get "#{repo_root}/files/#{filename}", filename
    template "#{Dir.pwd}/#{filename}", force: true if erb
  rescue OpenURI::HTTPError
    say red "Unable to obtain #{filename} from the repo #{repo_root}"
  end
end

def change_double_to_single_quotes(filename)
  comment "# Change double to single quotes"
  gsub_file filename, %r("), "'"
end

def remove_comments(filename)
  comment "# Remove generated comments"
  gsub_file filename, %r(^\s{2}?\#.*\n), ''
end

def remove_blank_lines(filename)
  comment "# Remove excess blank lines"
  gsub_file filename, %r((?m)^(?<!\w\n$)\n(?!\w+)), ''
end

def modernize_hash_syntax(filename)
  comment "# Change hashes to modern syntax"
  gsub_file filename, %r(([^\w^:]):([\w\d_]+)\s*=>), '\1\2:'
end

def annotate_app
  comment "# Annotate classes and routes"
  run 'annotate --sort -i -p top'
  run 'annotate -r'
end