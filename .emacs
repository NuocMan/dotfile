;;; emacs.el --- This is Valentin Grimaldi Emacs config files
(menu-bar-mode -1)
;;;(toggle-scroll-bar -1)
;;;(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(xterm-mouse-mode t)

;;; Package configs

(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package spacemacs-common
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-dark t))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode t))

(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))

(use-package ivy
  :ensure t
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
	 ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

;; (use-package ivy-rich
;;   :after ivy
;;   :custom
;;   (ivy-virtual-abbreviate 'full
;; 			  ivy-rich-switch-buffer-align-virtual-buffer t
;; 			  ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-set-display-transformer 'ivy-switch-buffer
;; 			       'ivy-rich-switch-buffer-transformer))

(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)))


;;; Config files

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(load-file "~/.emacs.d/bindings.el")
(load-file "~/.emacs.d/hooks.el")
