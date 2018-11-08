(setq debug-on-error t)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-linum-mode t)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)


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
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "C-x o") 'ace-window))

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
;;(ido-mode t)

;;(windmove-default-keybindings)

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
  helm-mode-fuzzy-match t
  helm-buffers-fuzzy-matching t
  helm-recentf-fuzzy-match t
  helm-locate-fuzzy-match t
  helm-semantic-fuzzy-match t
  helm-imenu-fuzzy-match t
  helm-completion-in-region-fuzzy-match t
  helm-candidate-number-list 150
  helm-split-window-in-side-p t
  helm-move-to-line-cycle-in-source t
  helm-display-header-line t
  helm-echo-input-in-header-line nil
  helm-autoresize-max-height 0
  helm-autoresize-min-height 20
  )
  :bind
  (("C-x b" . helm-buffers-list)
   ("M-y" . helm-show-kill-ring)
   ("M-x" . helm-M-x)
   )
  :config
  (helm-mode 1)
;;  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  )


(use-package undo-tree
  :ensure t)

(use-package magit
  :ensure t
  :bind
  (
   ("C-x g" . magit-status)
   )
  )

(use-package autopair
  :ensure t
  :config
  (autopair-global-mode 1)
  (setq autopair-autowrap t)
  )

(use-package helm-swoop
  :ensure t
  :bind
  (
   ("M-i" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   (:map helm-swoop-map
	 ("C-r" . helm-previous-line)
	 ("C-s" . helm-next-line)
	 )
   )
   :config
  ;; If this value is t, split window inside the current window
   (setq helm-swoop-split-with-multiple-windows t)
  )
	
(use-package docker-tramp
  :ensure t)

(use-package dockerfile-mode
  :ensure t)

(use-package helm-tramp
  :ensure t
  :bind
  (
   ("C-c s" . helm-tramp)
   )
  )

(use-package drag-stuff
  :ensure t
  :config
   (drag-stuff-global-mode 1)
   (drag-stuff-define-keys)
   )

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
