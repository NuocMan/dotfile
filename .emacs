;;; emacs.el --- Emacs configuration file

;;; Commentary:
;; This is Valentin Grimaldi Emacs config files
;;; Code:

(require 'package)
;;(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nuoc-elpa" . "https://nuocman.github.io/my-elpa/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
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
  (defun nuoc/edit-dotfile ()
    "Open dotfile bare repository"
    (interactive)
    (magit-status "~/.cfg"))
  :hook
  (before-save . delete-trailing-whitespace)
  :config
  (setq ring-bell-function 'ignore)
  (setq-default tab-width 2)
  (menu-bar-mode -1)
  (toggle-scroll-bar -1)
  (setq global-hl-line-mode 1)
  (tool-bar-mode -1)
  (column-number-mode 1)
  (ido-mode 1)
  (setq inhibit-startup-screen t)
  (setq require-final-newline 'ask)
  (setq delete-trailing-lines t)

  (global-hl-line-mode 1)
  (global-unset-key (kbd "C-z"))
  (global-set-key (kbd "C-z") 'my-suspend-frame)
  (global-unset-key (kbd "C-x C-b"))
  (global-set-key (kbd "C-x C-b") 'ibuffer)
  (global-set-key (kbd "C-c x") 'compile)
  (global-set-key (kbd "C-c c") 'recompile)

  ;; Try to use `user-emacs-directory`
  (setq backup-directory-alist '((concat user-emacs-directory "backups")))
  (setq custom-file (concat user-emacs-directory "emacs-custom.el"))
  (if (file-exists-p custom-file)
      (load custom-file)
      (make-empty-file custom-file))
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (windmove-default-keybindings 'meta))

(use-package editorconfig
  :ensure editorconfig
  :config (editorconfig-mode t))

(use-package whitespace
  :hook
  (prog-mode . whitespace-mode)
  :config
  (setq whitespace-style
        '(face trailing tabs spaces newline missing-newline-at-eof empty
               indentation space-after-tab space-before-tab space-mark
               tab-mark newline-mark)))

(use-package fill-column-indicator
  :hook
  (prog-mode . display-fill-column-indicator-mode))

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

(use-package treemacs
  :bind ("C-c C-f" . treemacs))

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
  (load-theme 'spacemacs-dark t)
  :pin nuoc-elpa)

(use-package display-line-numbers
  :ensure nil
  :hook
  (prog-mode . display-line-numbers-mode)
  :config
  (setq-default display-line-numbers-width 3))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package kubernetes
  :commands
  (kubernetes-overview)
  :config
  (setq kubernetes-poll-frequency 3600
        kubernetes-redraw-frequency 3600))

(use-package all-the-icons)

;; File type modes
(use-package yaml-mode)
(use-package dockerfile-mode)
(use-package kotlin-mode)
(use-package groovy-mode)
;; (use-package gradle-mode) Old AF

(use-package projectile
  :config
  (setq projectile-mode t)
  :bind
  ("C-c p" . projectile-command-map))

(use-package which-key
  :config
  (which-key-mode))

(use-package company
  :config
  (global-company-mode t))
;; (eglot-managed-mode . company-mode)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package lsp-java
  :config
  (let ((lombok-path (concat user-emacs-directory "lombok.jar")))
    (if (file-exists-p lombok-path)
        (setq lsp-java-vmargs
              (append lsp-java-vmargs
                      (list (concat "-javaagent:" (file-truename lombok-path)))))
      (message "Lombok jar missing"))))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (java-mode . lsp)
         (java-ts-mode . lsp))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
(use-package helm
  :config (helm-mode))
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
  :after lsp-mode
  :config (dap-auto-configure-mode))
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
(use-package dap-java
  :ensure nil)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))
(provide '.emacs)
;;; .emacs ends here
