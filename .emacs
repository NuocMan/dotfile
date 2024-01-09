;;; emacs.el --- Emacs configuration file

;;; Commentary:
;; This is Valentin Grimaldi Emacs config files
;;; Code:

(require 'package)
;;(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package emacs
  :preface
  (defun nuoc/edit-config ()
    "Open Emacs settings."
    (interactive)
    (find-file (concat "~/" ".emacs")))
  :config
	(setq ring-bell-function 'ignore)
  (setq-default tab-width 2)
  (menu-bar-mode -1)
  (toggle-scroll-bar -1)
	(setq global-hl-line-mode 1)
  (tool-bar-mode -1)
  (setq inhibit-startup-screen t)
  (setq require-final-newline 'ask)
	(global-hl-line-mode 1)
	(global-unset-key (kbd "C-z"))
	(global-set-key (kbd "C-z") 'my-suspend-frame)
	(global-unset-key (kbd "C-x C-b"))
	(global-set-key (kbd "C-x C-b") 'ibuffer)
	(global-set-key (kbd "C-c x") 'compile)
	(global-set-key (kbd "C-c c") 'recompile)

	;; Try to use `user-emacs-directory`
	(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))
	(setq custom-file (concat user-emacs-directory "emacs-custom.el"))
	(put 'upcase-region 'disabled nil)
	(put 'downcase-region 'disabled nil)
	(windmove-default-keybindings 'meta))

(use-package editorconfig
	:config (editorconfig-mode t))

(use-package cc-vars
  :ensure nil
  :mode ("\\.inl\\'" . c++-mode)
  :config
  (setq c-default-style '((java-mode . "java")
                          (awk-mode  . "awk")
                          (c++-mode  . "bsd")
                          (c-mode    . "bsd")
                          (other     . "gnu")))
  (setq-default c-basic-offset 2))

(use-package doom-modeline
  :init
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-lsp t
        doom-modeline-column-zero-based t)
  :config (doom-modeline-mode))


(use-package spacemacs-theme
  :config
  (load-theme 'spacemacs-dark t))

(use-package display-line-numbers
  :ensure nil
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq-default display-line-numbers-width 3))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package ivy
  :defer 0.1
  :diminish
  :bind (("C-c C-r" . ivy-resume)
				 ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-count-format "(%d/%d) ")
  (ivy-use-virtual-buffers t)
  :config (ivy-mode))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)
				 ("C-r" . swiper)))

(use-package kubernetes
  :commands (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))
(fset 'k8s 'kubernetes-overview)

(use-package all-the-icons)

;; File type modes
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package kotlin-mode)
(use-package groovy-mode)
(use-package gradle-mode)

(use-package company
	:hook (eglot-managed-mode . company-mode))

(use-package eglot
  :hook (((c-mode
					 cc-mode
					 sh-mode
					 dockerfile-mode
					 sql-mode
					 js-mode
					 typescript-ts-mode
					 java-mode
					 kotlin-mode) . eglot-ensure))
  :custom
  (eglot-autoshutdown t)
  (eglot-events-buffer-size 0)
  (eglot-extend-to-xref nil)
  (eglot-ignored-server-capabilities
   '(:hoverProvider
     :documentHighlightProvider
     :documentFormattingProvider
     :documentRangeFormattingProvider
     :documentOnTypeFormattingProvider
     :colorProvider
     :foldingRangeProvider)))

(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
(provide '.emacs)
;;; .emacs ends here
