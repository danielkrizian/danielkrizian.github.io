# options(WordpressLogin = c(danielkrizian = "d1k5yr1s"), WordpressURL = "http://quantology.wordpress.com/")
# 
# getUsersBlogs()


knit2wp.com <- function(file) {
    require(XML)
    post.content <- readLines(file)
    post.content <- gsub(" <", "&nbsp;<", post.content)
    post.content <- gsub("> ", ">&nbsp;", post.content)
    post.content <- htmlTreeParse(post.content)
    post.content <- paste(capture.output(print(post.content$children$html$children$body, 
        indent = FALSE, tagSeparator = "")), collapse = "\n")
    post.content <- gsub("<?.body>", "", post.content)
    post.content <- gsub("<p>", "<p style=\"text-align: justify;\">", post.content)
    post.content <- gsub("<?pre><code class=\"r\">", "\\[sourcecode language=\"r\"\\]\\\n ", 
        post.content)
    post.content <- gsub("<?pre><code class=\"no-highlight\">", "\\[sourcecode\\]\\\n ", 
        post.content)
    post.content <- gsub("<?/code></pre>", "\\\n\\[/sourcecode\\]", post.content)
    return(post.content)
}

txt <- knit2wp.com("C:/R/Research/CalendarStrategy/calendar.html")