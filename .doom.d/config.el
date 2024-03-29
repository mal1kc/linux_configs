(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell (executable-find "fish"))

(setq-default explicit-shell-file-name (executable-find "fish"))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email

;; clients, file templates and snippets. It is optional.
;;(setq user-full-name "John Doe"
;;     user-mail-address "john@doe.com")

(setq user-full-name "malik kökçan")

;; (setq doom-theme 'sanityinc-tomorrow-night)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Iosevka" :size 20 :weight 'light)
      doom-big-font (font-spec :family "Hack Nerd Font" :size 24)
     )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq scroll-margin 10)

(beacon-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(map! :leader
   (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-open-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
 )
;;Get file icons in dired
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;;With dired-open plugin, you can launch external programs for certain extensions
;;For example, I set all .png files to open in 'nsxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "nsxiv")
                              ("jpg" . "nsxiv")
                              ("png" . "nsxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(map! :leader
      (:prefix ("e". "evaluate")
       :desc "Evaluate elisp in buffer" "b" #'eval-buffer
       :desc "Evaluate defun" "d" #'eval-defun
       :desc "Evaluate elisp expression" "e" #'eval-expression
       :desc "Evaluate last sexpression" "l" #'eval-last-sexp
       :desc "Evaluate elisp in region" "r" #'eval-region))

(xterm-mouse-mode 1)

(dolist (hook '(text-mode-hook org-mode-hook markdown-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))
  ))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(map! :leader
      :desc "Org babel tange" "m B" #'org-babel-tangle)
(after! org
  (setq org-directory "~/org/"
        org-agenda-files '("~/org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
                ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
          '(("google" . "http://www.google.com/search?q=")
            ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
            ("ddg" . "https://duckduckgo.com/?q=")
            ("pydoc" . "https://docs.python.org/3/search.html?q=")
            ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
          '((sequence
             "TODO(t)"           ; A task that is ready to be tackled
             "BLOG(b)"           ; Blog writing assignments
             "PROJ(p)"           ; A project that contains other tasks
             "WAIT(w)"           ; Something is holding up this task
             "|"                 ; The pipe necessary to separate "active" states and "inactive" states
             "DONE(d)"           ; Task has been completed
             "CANCELLED(c)" )))) ; Task has been cancelled

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1 )

(map! :leader
      (:prefix ("w" . "window")
       :desc "Winner redo" "<right>" #'winner-redo
       :desc "Winner undo" "<left>" #'winner-undo))

(use-package! format-all
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))

;; Enable ccls for all c++ files, and platformio-mode only
;; when needed (platformio.ini present in project root).

(add-to-list 'auto-mode-alist '("\\.ino\\'" . platformio-mode))
(add-to-list 'auto-mode-alist '("\\.ino\\'" . cpp-mode))

(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)
                           (platformio-conditionally-enable)))


;; if platformio.ini file exists
;; enable platformio-mode and create compile-commands.json for clangd
;; platformio run -t compiledb ->  generates compile-commands.json for clangd

(add-hook 'projectile-after-switch-project-hook
                (lambda ()
                (if (file-exists-p (concat (projectile-project-root) "ini.platformio"))
                    (progn (message "platformio.ini file found")
                        (require 'platformio-mode)
                        (platformio-mode t)
                        (platformio--run "-t compiledb")
                        )
                (message "No platformio.ini file found"))
                    ))


(add-hook 'c++-mode-hook (lambda ()
                           (lsp-deferred)
                           (platformio-conditionally-enable)))

(defun magit-add-current-buffer ()
    "Adds (with force) the file from the current buffer to the git repo"
    (interactive)
    (shell-command (concat "git add -f "
               (shell-quote-argument buffer-file-name))))

(dolist (hook '(text-mode-hook org-mode-hook markdown-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))
  ))

;; accept completion from copilot and fallback to company
(use-package! copilot
  ;; :hook (prog-mode . copilot-mode)
  ;; complete with enter and tab
  :bind (:map copilot-completion-map
                  ("<return>" . 'copilot-accept-completion-by-line)
                  ("<tab>" . 'copilot-accept-completion)
                  ("TAB" . 'copilot-accept-completion)
                  ("C-TAB" . 'copilot-accept-completion-by-word)
                  ("C-<tab>" . 'copilot-accept-completion-by-word)
                  ))

(map! :mode copilot-mode "C-<return>" #'copilot-accept-completion-by-line)
(map! :mode copilot-mode "<tab>" #'copilot-accept-completion)
(map! :mode copilot-mode "TAB" #'copilot-accept-completion)

(after! docker
(setq docker-command "podman")
 )

(map! :leader "ü" #'+popup/toggle )
(map! :leader "ö" #'mark-sexp )
(map! "C-ç" #'comment-line )
(map! "C-ş" #'er/expand-region ) ;; similliar to mark-sexp but slightly different
(map! :leader "r" #'recentf-open-files )

(after! hl-todo
    (setq hl-todo-keyword-faces
        '(("HOLD"   . "#fff8dc")
        ("TODO"   . "#7fff00")
        ("NEXT"   . "#dca3a3")
        ("THEM"   . "#dc8cc3")
        ("PROG"   . "#7cb8bb")
        ("OKAY"   . "#7cb8bb")
        ("DONT"   . "#5f7f5f")
        ("FAIL"   . "#8c5353")
        ("DONE"   . "#afd8af")
        ("NOTE"   . "#d0bf8f")
        ("HACK"   . "#dfff8f")
        ("TEMP"   . "#ddaa6f")
        ("FIXME"  . "#cc9393")
        ("DEPRECATED" . "#cb4b16")
        ("IMPORTANT" . "#8b0000")
    )))

(add-hook 'prog-mode-hook #'hl-todo-mode)

;; (map! :g "C-ğ" #'mc/edit-lines)
;; (map! :g "C->" #'mc/mark-next-like-this)
;; (map! :g "C-<" #'mc/mark-previous-like-this)
;; (map! :g "ğ" #'mc/mark-all-like-this-dwim)

(after! poetry
        (setq poetry-tracking-strategy 'projectile
                poetry-tracking-strategy-project-root-files '("pyproject.toml"))
  )

(after! lsp-mode
  (setq lsp-enable-indentation t)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-modeline-code-actions-enable t)
  (setq lsp-modeline-diagnostics-enable t)
  (setq lsp-headerline-breadcrumb-enable t)
  (after! lsp-ui
    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-sideline-diagnostic-max-lines 2))
  )

(setq projectile-project-search-path '(("~/projeler" . 4) ("~/projects++" . 4) ))

(map! :prefix "C-h"
      (:prefix ("D" . "devdocs")
               :desc "lookup" "l" #'devdocs-lookup
               :desc "update all docs" "u" #'devdocs-update-all
               :desc "delete doc" "d" #'devdocs-delete
               :desc "install doc" "i" #'devdocs-install
))

(add-hook 'csharp-mode-hook (lambda ()
                           (lsp-deferred)
                           (copilot-mode)
                ))

(add-hook 'csharp-mode-hook #'format-all-mode)
