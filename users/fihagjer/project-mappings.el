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
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml" "jsTestDriver.conf" "jawrbundle.properties"))

;;File encodings
(defun enforce-coding-system-priority ()
  (let ((pref (car (coding-system-priority-list)))
        (list (find-coding-systems-region (point-min) (point-max))))
    (when (or (memq 'undecided list) (memq pref list))
      (setq buffer-file-coding-system pref))))

(defun iso-encode ()
  (setq-default buffer-file-coding-system 'iso-8859-1)
;;  (add-hook 'before-save-hook 'enforce-coding-system-priority)
  (prefer-coding-system 'iso-8859-1)
  (setq locale-coding-system 'iso-8859-1) ; pretty
  (set-terminal-coding-system 'iso-8859-1) ; pretty
  (set-keyboard-coding-system 'iso-8859-1) ; pretty
  (set-selection-coding-system 'iso-8859-1)) ; please
;;end file encodings


;; Emacs
(defun custom-persp/emacs ()
  (interactive)
  (custom-persp "emacs"
                (find-file "~/.emacs.d/init.el")))

(project-specifics ".emacs.d"
                   (ffip-local-excludes "swank")
                   (ffip-local-patterns "*.el" "*.md" "*.org"))
;; FINN
(defun custom-persp/finn ()
  (interactive)
  (custom-persp "finn"
                (find-file "/finn/svn/trunk")))

(project-specifics "/finn/svn/trunk"
                   (iad-mode 1)
                   (iso-encode)
                   (setup-find-file-in-project))
;; MinFinn
(defun custom-persp/minfinn ()
  (interactive)
  (custom-persp "minfinn"
                (find-file "/finn/svn/trunk/minfinn")))

(project-specifics "/finn/svn/trunk/minfinn"
                   (iad-mode 1)
                   (iso-encode)
                   (setup-find-file-in-project))
;; strapon-core
(defun custom-persp/strapon-core ()
  (interactive)
  (custom-persp "strapon-core-js"
                (find-file "/finn/git/strapon-core-js/")))

(project-specifics "/finn/git/strapon-core-js/"
                   (common-core-mode 1)
                   (setup-find-file-in-project))
;; strapon-core
(defun custom-persp/mupf ()
  (interactive)
  (custom-persp "mupf-js"
                (find-file "/finn/git/mupf-js/")))

(project-specifics "/finn/git/mupf-js/"
                   (common-core-mode 1)
                   (setup-find-file-in-project))


(define-key persp-mode-map (kbd "C-x p e") '(lambda () (interactive) (set-background-color "black") (custom-persp/emacs)))

(define-key persp-mode-map (kbd "C-x p f") '(lambda () (interactive) (set-background-color "black") (custom-persp/finn)))
(define-key persp-mode-map (kbd "C-x p p") '(lambda () (interactive) (set-background-color "black") (custom-persp/minfinn)))
(define-key persp-mode-map (kbd "C-x p s") '(lambda () (interactive) (set-background-color "black") (custom-persp/strapon-core)))
(define-key persp-mode-map (kbd "C-x p m") '(lambda () (interactive) (set-background-color "black") (custom-persp/mupf)))

(defvar bg-color-branched "dark slate gray")
(define-key persp-mode-map (kbd "C-x p b f") '(lambda () (interactive) (set-background-color bg-color-branched) (custom-persp/finn)))
(define-key persp-mode-map (kbd "C-x p b p") '(lambda () (interactive) (set-background-color bg-color-branched) (custom-persp/minfinn)))
(define-key persp-mode-map (kbd "C-x p b s") '(lambda () (interactive) (set-background-color bg-color-branched) (custom-persp/strapon-core)))
(define-key persp-mode-map (kbd "C-x p b m") '(lambda () (interactive) (set-background-color bg-color-branched) (custom-persp/mupf)))
