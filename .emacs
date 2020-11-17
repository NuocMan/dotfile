(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
   Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (unless (package-installed-p package)
       (package-install package)))
   packages))

(ensure-package-installed
 'magit
 'magit-todos
 'counsel
 'irony
 'flycheck-irony
 'doom-modeline
 'ivy
 'swiper
 'rainbow-delimiters
 'spacemacs-theme
 'multi-term
 )

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(load-file "~/.emacs.d/bindings.el")
(load-file "~/.emacs.d/hooks.el")
