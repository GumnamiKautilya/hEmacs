;; Final verification init.el
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(set-background-color "black")
(set-foreground-color "green")
(message "✅ ~/.config/emacs/init.el loaded")
;; Enable relative line numbers globally
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
;; Initialize package system
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Enable Evil Mode
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)  ;; Needed if using evil-collection later
  :config
  (evil-mode 1))

;; Optional: Relative line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(general which-key treemacs evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(treemacs-directory-face ((t (:background "#282c34"))))
 '(treemacs-file-face ((t (:background "#282c34"))))
 '(treemacs-fringe-indicator-face ((t (:background "#282c34"))))
 '(treemacs-root-face ((t (:background "#282c34")))))

;; Catppuccin theme
(use-package catppuccin-theme
  :ensure t
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin :no-confirm)
  ;; Set custom background color
  (set-face-background 'default "#282c34"))

;; Treemacs background match Catppuccin




  ;; Treemacs - file tree explorer
(use-package treemacs
  :ensure t
  :defer t
  :bind
  (:map global-map
        ("C-x t t" . treemacs)         ;; toggle tree
        ("C-x t 1" . treemacs-delete-other-windows)
        ("C-x t B" . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file))
  :config
  (setq treemacs-width 30))

(defun reload-init-file ()
  "Reload ~/.config/emacs/init.el."
  (interactive)
  (load-file (expand-file-name "~/.config/emacs/init.el"))
  (message "Emacs config reloaded!"))

;; Bind to a key, for example F5
(global-set-key (kbd "<f5>") #'reload-init-file)


(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))  ;; delay in seconds before popup appears

;; General.el: Leader key bindings
(use-package general
  :after evil
  :config
  ;; Set space as the leader key
  (general-create-definer my/leader-keys
    :keymaps '(normal visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; Example bindings under SPC
  (my/leader-keys
    "f"  '(:ignore t :which-key "files")
    "e" '(treemacs :which-key "explorer")  ;; SPC e to open Treemacs
    "ff" '(find-file :which-key "find file")
    "fs" '(save-buffer :which-key "save file")
    "q"  '(save-buffers-kill-terminal :which-key "quit")
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(treemacs :which-key "toggle treemacs")
    ))

(with-eval-after-load 'treemacs
  (evil-define-key 'normal treemacs-mode-map
    (kbd "h") #'treemacs-collapse-parent-node
    (kbd "l") #'treemacs-RET-action
    (kbd "j") #'treemacs-next-line
    (kbd "k") #'treemacs-previous-line))
