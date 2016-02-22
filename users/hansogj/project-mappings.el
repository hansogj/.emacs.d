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

(defun setup-find-file-in-finn-project ()
  (ffip-local-excludes "target" "overlays" "node_modules" "grunt_temp")
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml" "jsTestDriver.conf" "jawrbundle.properties" "*.rb" "*.feature"))

(defun setup-find-file-in-project ()
  (ffip-local-excludes "target" "overlays" "node_modules" "grunt_temp")
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml"))


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
                (set-background-color "#2d3743")
                (find-file "/git/bin/")))

(project-specifics "/git/bin")

(defun custom-persp/dropbox ()
  (interactive)
  (custom-persp "dropbox"
                (set-background-color "#2d3743")
                (find-file "~/Dropbox/")))

(project-specifics "~/Dropbox")


(defun custom-persp/eika-ahv ()
  (interactive)
  (custom-persp "eika-ahv"
                (set-background-color "#2d3743")
                (find-file "/git/eika/antihvitvask/portal/intraweb/src/angular-app/")))
(project-specifics "/git/eika/antihvitvask/portal/intraweb/src/angular-app/")

(defun custom-persp/eika-raadgiverportal_boostrap-lib ()
  (interactive)
  (custom-persp "eika-raadgiverportal_boostrap-lib"
                (find-file "/git/eika/raadgiverportal_boostrap-lib/")))
(project-specifics "/git/eika/raadgiverportal_boostrap-lib/")


(defun custom-persp/bli_kunde ()
  (interactive)
  (custom-persp "eika-bli-kunde"
                (set-background-color "#2d3743")
                (find-file "/git/eika/bli_kunde/nettbank/web/src/angular-app/")
                (set-background-color  "DarkSlateGray")))
(project-specifics "/git/eika/bli_kunde/nettbank/web/src/angular-app/"
  (setup-find-file-in-finn-project))


(defun custom-persp/eika-erklaring ()
  (interactive)
  (custom-persp "eika-eika-erklaring"
                (set-background-color "#2d3743")
                (find-file "/git/eika/antihvitvask-erklaering-angularjs-lib/")
                (set-background-color  "gray20")))
(project-specifics "/git/eika/antihvitvask-erklaering-angularjs-lib/")


;; cucumber
(defun custom-persp/stories-framework ()
  (interactive)
  (custom-persp "stories-framework"
                (set-background-color "black")
                (find-file "/finn/git/stories-framework/")))

(project-specifics "/finn/git/stories-framework/"
  (setup-find-file-in-finn-project))

;; self-service
(defun custom-persp/self-service ()
  (interactive)
  (custom-persp "self-service"
                (set-background-color "black")
                (find-file "/finn/git/self-service/")))

(project-specifics "/finn/git/self-service/"
  (setup-find-file-in-finn-project))

;; Finn

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
                     (find-file ,(concat "/finn/git/" name "/"))))

     (project-specifics ,(concat "/finn/git/" name "/")
       (set (make-local-variable 'sgml-basic-offset) 4)
       (set (make-local-variable 'nxml-child-indent) 4)



       (cond
        ((string= ,name "iad")
         (iad-mode 1))
        ((string= ,name "mfinn")
         (mfinn-mode 1))
        ((string= ,name "self-service")
         (self-service-mode 1))
        ((string= ,name "realestate-upsale")
         (realestate-upsale-mode 1))
        ((string= ,name "organisation-management-web")
         (organisation-management-web-mode 1))
        (t
         (module-mode 1)))

       ;; (case ,name
       ;;   ("iad"  (iad-mode 1))
       ;;   ("mfinn" (mfinn-mode 1))
       ;;   (otherwise module-mode 1))

       (setup-find-file-in-finn-project))

     (define-key persp-mode-map (kbd ,(concat "C-x p " shortcut)) ',(intern (concat "custom-persp/" name)))
     (define-key persp-mode-map (kbd ,(concat "C-x p B " shortcut)) ',(intern (concat "custom-persp/" name "-branched")))))

(def-finn-project-with-branch "i" "iad")
(def-finn-project-with-branch "m" "mupf-js")
(def-finn-project-with-branch "n" "mfinn")
;;(def-finn-project-with-branch "c" "core-js")
(def-finn-project-with-branch "c s" "common-validator-js")
(def-finn-project-with-branch "a n" "analytics-js")

(def-finn-project-with-branch "o m" "organisation-management-web")
(def-finn-project-with-branch "r u" "realestate-upsale")
(def-finn-project-with-branch "s j" "strapon-java-web")
(def-finn-project-with-branch "s c" "strapon-core-js")
(def-finn-project-with-branch "s w" "strapon-core-web")
(def-finn-project-with-branch "s s" "self-service")
(def-finn-project-with-branch "s p" "spid-js")

(define-key persp-mode-map (kbd "C-x p e m") 'custom-persp/emacs)
(define-key persp-mode-map (kbd "C-x p e e") 'custom-persp/eika-erklaring)
(define-key persp-mode-map (kbd "C-x p b k") 'custom-persp/bli_kunde)
(define-key persp-mode-map (kbd "C-x p e a") 'custom-persp/eika-ahv)
(define-key persp-mode-map (kbd "C-x p e r") 'custom-persp/eika-raadgiverportal_boostrap-lib)
(define-key persp-mode-map (kbd "C-x p b i") 'custom-persp/bin)
(define-key persp-mode-map (kbd "C-x p d")   'custom-persp/dropbox)
(define-key persp-mode-map (kbd "C-x p s f") 'custom-persp/stories-framework)
