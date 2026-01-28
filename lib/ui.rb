module UI
  # Draws a simple ASCII frame around an array of lines
  def self.frame(title, lines)
    lines = Array(lines)
    inner_width = ([title.size] + lines.map(&:size)).max + 2
    top = "+#{'-' * inner_width}+"
    title_line = "| #{title.ljust(inner_width - 2)}|"
    separator = "+#{'-' * inner_width}+"
    body = lines.map { |line| "| #{line.ljust(inner_width - 2)}|" }
    ([top, title_line, separator] + body + [top]).join("\n")
  end

  # Adds bullet points to each line
  def self.bullets(lines)
    Array(lines).map { |line| "• #{line}" }
  end
end