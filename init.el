(setq debug-on-error t)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)


;; Changing windows in emacs
(global-set-key (kbd "C-x o") 'ace-window)

;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))


;; Display column number
(column-number-mode)
;; show the other parenthesis
(show-paren-mode)

;; Highlight current line
(global-hl-line-mode t)

;; auto completion
(ido-mode t)

;;(windmove-default-keybindings)

