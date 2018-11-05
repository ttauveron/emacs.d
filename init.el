(setq debug-on-error t)

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(global-linum-mode t)

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
(ido-mode t)

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
  helm-echo-input-in-header-line t
  helm-autoresize-max-height 0
  helm-autoresize-min-height 20)
  :config
  (helm-mode 1)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
;;  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  )

(use-package undo-tree
  :ensure t)

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package autopair
  :ensure t
  :config
  (autopair-global-mode 1)
  (setq autopair-autowrap t)
  )

(use-package helm-swoop
  :ensure t
  :config
  (global-set-key (kbd "M-i") 'helm-swoop)
  (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows t)
  )
	
(use-package docker-tramp
  :ensure t)

(use-package helm-tramp
  :ensure t
  :config
  (define-key global-map (kbd "C-c s") 'helm-tramp))



(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

