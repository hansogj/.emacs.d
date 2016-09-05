(require 'cl)
(require 'finn-projects)
(require 'eika-projects)

(defmacro project-specifics (name &rest body)
  `(progn
     (add-hook 'find-file-hook
               (lambda ()
                 (when (string-match-p ,name (buffer-file-name))
                   ,@body)))
     (add-hook 'dired-after-readin-hook
               (lambda ()
                 (when (string-match-p ,name (dired-current-directory))
                   ,@body)))))



;; Emacs
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (set-background-color "black")
                (find-file "~/.emacs.d/init.el")))

(project-specifics ".emacs.d"
  (ffip-local-excludes "swank")
  (ffip-local-patterns "*.el" "*.md" "*.org"))

;; bin
(defun custom-persp/bin ()
  (interactive)
  (custom-persp "bin"
                (set-background-color kindOfBlue)
                (find-file "/git/bin/")))
(project-specifics "/git/bin")

(defun custom-persp/dropbox ()
  (interactive)
  (custom-persp "dropbox"
                (set-background-color poisonGreen)
                (find-file "~/Dropbox/")))
(project-specifics "~/Dropbox")

(define-key persp-mode-map (kbd "C-x p . e") 'custom-persp/emacs)
(define-key persp-mode-map (kbd "C-x p b i") 'custom-persp/bin)
(define-key persp-mode-map (kbd "C-x p d")   'custom-persp/dropbox)
(define-key persp-mode-map (kbd "C-x p s f") 'custom-persp/stories-framework)
