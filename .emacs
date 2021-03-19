;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/code/emacs")
(load "init")
(setq custom-file "~/code/emacs/emacs-custom.el")
(load custom-file)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
