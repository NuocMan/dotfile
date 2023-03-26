;;; emacs.el --- Emacs configuration file

;;; Commentary:
;; This is Valentin Grimaldi Emacs config files
;;; Code:

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

(normal-erase-is-backspace-mode)
(xterm-mouse-mode t)
(global-hl-line-mode 1)
;;(global-display-line-numbers-mode)
(setq column-number-mode t)

(setq require-final-newline 'ask)

;;; Package configs

(setq-default c-basic-offset 2)
(setq-default c-default-style
      '((c-mode . "bsd")
	(java-mode . "java")
	(awk-mode . "awk")
	(other . "gnu")))

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

(use-package all-the-icons
  :ensure t)

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

(use-package swiper
  :ensure t
  :after ivy
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)))

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

(use-package company
  :ensure t
  :diminish company-mode
  :hook ((prog-mode . global-company-mode)
	 (irony-mode . irony-cdb-autosetup-compile-options)))

(use-package irony
  :ensure t
  :hook ((c++-mode . irony-mode)
	 (c-mode . irony-mode)))

(use-package company-irony
  :ensure t
  :after (company irony)
  :config (add-to-list 'company-backends 'company-irony))

(use-package company-jedi
  :ensure t
  :after company
  :config (add-to-list 'company-backends 'company-jedi))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode))

(use-package auto-virtualenvwrapper
  :ensure t
  :hook (python-mode . auto-virtualenvwrapper-activate))

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))
(fset 'k8s 'kubernetes-overview)

(use-package yaml-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package kotlin-mode
  :ensure t)

(use-package groovy-mode
  :ensure t)

(use-package gradle-mode
  :ensure t)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(use-package mu4e)
(setq mu4e-get-mail-command "mbsync gmail")

;;; Config files

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

;;; Bindings
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "<mouse-4>")
		#'(lambda ()
		   (interactive)
		   (scroll-down 1)))
(global-set-key (kbd "<mouse-5>")
		#'(lambda ()
		   (interactive)
		   (scroll-up 1)))

(global-set-key (kbd "C-c x") 'compile)
(global-set-key (kbd "C-c c") 'recompile)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(windmove-default-keybindings 'meta)

(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-z") 'my-suspend-frame)

(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
