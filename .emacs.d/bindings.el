(global-set-key (kbd "<mouse-4>")
		'(lambda ()
		   (interactive)
		   (scroll-down 1)))
(global-set-key (kbd "<mouse-5>")
		'(lambda ()
		   (interactive)
		   (scroll-up 1)))

(global-set-key (kbd "C-c x") 'compile)
(global-set-key (kbd "C-c c") 'recompile)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(windmove-default-keybindings 'meta)
