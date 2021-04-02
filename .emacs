;;; emacs.el --- This is Valentin Grimaldi Emacs config files
;;; Commentary:

;;; Code: Frame config

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(xterm-mouse-mode t)
(global-hl-line-mode 1)
(global-display-line-numbers-mode)
(setq require-final-newline 'ask)

;;; Package configs

(setq-default c-basic-offset 2)
(setq c-default-style
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

(use-package irony
  :ensure t
  :hook ((c++-mode . irony-mode)
	 (c-mode . irony-mode)))

(use-package company
  :ensure t
  :diminish company-mode
  :hook ((prog-mode . global-company-mode)
	 (irony-mode . irony-cdb-autosetup-compile-options)))

(use-package company-irony
  :ensure t
  :after (company irony)
  :config (add-to-list 'company-backends 'company-irony))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;;; Config files

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(load-file "~/.emacs.d/bindings.el")
