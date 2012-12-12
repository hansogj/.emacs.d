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
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "pom.xml" "jsTestDriver.conf" "jawrBundle.properties"))

;; Emacs
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (find-file "~/.emacs.d/init.el")))

(project-specifics ".emacs.d"
                   (ffip-local-excludes "swank")
                   (ffip-local-patterns "*.el" "*.md" "*.org"))

(define-key persp-mode-map (kbd "C-x p e") 'custom-persp/emacs)


;; FINN
(defun custom-persp/finn ()
  (interactive)
  (custom-persp "finn"
                (find-file "/finn/svn/trunk")))

(project-specifics "/finn/svn/trunk"
                   (iad-mode 1)
                   (setup-find-file-in-project))

(define-key persp-mode-map (kbd "C-x p f") 'custom-persp/finn)


;; MinFinn
(defun custom-persp/minfinn ()
  (interactive)
  (custom-persp "minfinn"
                (find-file "/finn/svn/trunk/minfinn")))

(project-specifics "/finn/svn/trunk/minfinn"
                   (iad-mode 1)
                   (setup-find-file-in-project))

(define-key persp-mode-map (kbd "C-x p m") 'custom-persp/minfinn)


;; COMMONS-WEB
(defun custom-persp/commons-web ()
  (interactive)
  (custom-persp "commons-web"
                (find-file "/finn/repo/common-web/trunk/commons-web/")))

(project-specifics "/finn/repo/common-web/trunk/commons-web/"
                   (setup-find-file-in-project))

(define-key persp-mode-map (kbd "C-x p w") 'custom-persp/commons-web)

;; Analytics
(defun custom-persp/analytics ()
  (interactive)
  (custom-persp "analytics-js"
                (find-file "/finn/repo/common-web/trunk/analytics-js/")))

(project-specifics "/finn/repo/common-web/trunk/analytics-js/"
                   (setup-find-file-in-project))

(define-key persp-mode-map (kbd "C-x p a") 'custom-persp/analytics)
