# The Main File
load "package.ring"
load "lib.ring"
load "src/utils/color.ring"

func main
	banner = []
	banner[:topBorder] = colorText([:text = "╭───────────────────────────────────────────────╮", :color = :BRIGHT_BLUE, :style = :BOLD])
	banner[:tEmptyLine] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	title = "Ring HTML"
	titlePad = floor((47 - len(title)) / 2)
	banner[:titleLine] = colorText([:text = "│" + space(titlePad), :color = :BRIGHT_BLUE]) + colorText([:text = title, :color = :CYAN, :style = :BOLD]) + colorText([:text = space(47-titlePad-len(title)) + "│", :color = :BRIGHT_BLUE])
	banner[:tEmptyLine2] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	
	# Description lines
	desc1 = "A high-performance HTML5 parser"
	desc1Pad = floor((47 - len(desc1)) / 2)
	banner[:descLine1] = colorText([:text = "│" + space(desc1Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc1, :color = :WHITE]) + colorText([:text = space(47-desc1Pad-len(desc1)) + "│", :color = :BRIGHT_BLUE])
	
	desc2 = "with CSS selectors and DOM manipulation"
	desc2Pad = floor((47 - len(desc2)) / 2)
	banner[:descLine2] = colorText([:text = "│" + space(desc2Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc2, :color = :WHITE]) + colorText([:text = space(47-desc2Pad-len(desc2)) + "│", :color = :BRIGHT_BLUE])
	
	desc3 = "for the Ring programming language."
	desc3Pad = floor((47 - len(desc3)) / 2)
	banner[:descLine3] = colorText([:text = "│" + space(desc3Pad), :color = :BRIGHT_BLUE]) + colorText([:text = desc3, :color = :WHITE]) + colorText([:text = space(47-desc3Pad-len(desc3)) + "│", :color = :BRIGHT_BLUE])
	
	banner[:tEmptyLine3] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	
	versionStr = "Version " + aPackageInfo[:version]
	versionPad = floor((47 - len(versionStr)) / 2)
	banner[:versionLine] = colorText([:text = "│" + space(versionPad), :color = :BRIGHT_BLUE]) + colorText([:text = versionStr, :color = :YELLOW, :style = :BOLD]) + colorText([:text = space(47-versionPad-len(versionStr)) + "│", :color = :BRIGHT_BLUE])
	authorStr = "Author: ysdragon"
	authorPad = floor((47 - len(authorStr)) / 2)
	banner[:authorLine] = colorText([:text = "│" + space(authorPad), :color = :BRIGHT_BLUE]) + colorText([:text = authorStr, :color = :MAGENTA]) + colorText([:text = space(47-authorPad-len(authorStr)) + "│", :color = :BRIGHT_BLUE])
	urlStr = "https://github.com/ysdragon"
	urlPad = floor((47 - len(urlStr)) / 2)
	banner[:urlLine] = colorText([:text = "│" + space(urlPad), :color = :BRIGHT_BLUE]) + colorText([:text = urlStr, :color = :GREEN, :style = :UNDERLINE]) + colorText([:text = space(47-urlPad-len(urlStr)) + "│", :color = :BRIGHT_BLUE])
	banner[:bEmptyLine] = colorText([:text = "│                                               │", :color = :BRIGHT_BLUE])
	banner[:bottomBorder] = colorText([:text = "╰───────────────────────────────────────────────╯", :color = :BRIGHT_BLUE, :style = :BOLD])
	for line in banner
		? line[2]
	next