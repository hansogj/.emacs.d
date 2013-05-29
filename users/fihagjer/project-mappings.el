(require 'cl)

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

(defun setup-find-file-in-project ()
  (ffip-local-excludes "target" "overlays")
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml" "jsTestDriver.conf" "jawrbundle.properties" "*.rb" "*.feature"))

;; Emacs
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (set-background-color "black")
                (find-file "~/.emacs.d/init.el")))

(project-specifics ".emacs.d"
  (ffip-local-excludes "swank")
  (ffip-local-patterns "*.el" "*.md" "*.org"))

;; cucumber
(defun custom-persp/stories-framework ()
  (interactive)
  (custom-persp "stories-framework"
                (set-background-color "black")
                (find-file "/finn/git/stories-framework/")))

(project-specifics "/finn/git/stories-framework/"
  (setup-find-file-in-project))

;; FINN

(defmacro def-finn-project-with-branch (shortcut name)
  `(progn

     (defun ,(intern (concat "custom-persp/" name)) ()
       (interactive)
       (custom-persp ,name
                     (set-background-color "black")
                     (find-file ,(concat "/finn/git/" name "/"))))

     (defun ,(intern (concat "custom-persp/" name "-branched")) ()
       (interactive)
       (message (string= "iad" ,name))
       (custom-persp ,name
                     (set-background-color "RosyBrown4")
                     (find-file ,(concat "/finn/git/" name "/"))))

     (project-specifics ,(concat "/finn/git/" name "/")

       (cond
        ((string= ,name "iad")
         (iad-mode 1))
        ((string= ,name "mfinn")
         (mfinn-mode 1))
        (t
         (module-mode 1)))

       ;; (case ,name
       ;;   ("iad"  (iad-mode 1))
       ;;   ("mfinn" (mfinn-mode 1))
       ;;   (otherwise module-mode 1))

       (setup-find-file-in-project))

     (define-key persp-mode-map (kbd ,(concat "C-x p " shortcut)) ',(intern (concat "custom-persp/" name)))
     (define-key persp-mode-map (kbd ,(concat "C-x p b " shortcut)) ',(intern (concat "custom-persp/" name "-branched")))))

(def-finn-project-with-branch "i" "iad")
(def-finn-project-with-branch "m" "mupf-js")
(def-finn-project-with-branch "n" "mfinn")
(def-finn-project-with-branch "c" "core-js")
(def-finn-project-with-branch "a" "analytics-js")
(def-finn-project-with-branch "w" "strapon-java-web")

(define-key persp-mode-map (kbd "C-x p e") 'custom-persp/emacs)
(define-key persp-mode-map (kbd "C-x p s") 'custom-persp/stories-framework)
