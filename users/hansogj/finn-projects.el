(defun setup-find-file-in-finn-project ()
  (ffip-local-excludes "target" "overlays" "node_modules" "grunt_temp")
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml" "jsTestDriver.conf" "jawrbundle.properties" "*.rb" "*.feature"))


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

(def-finn-project-with-branch "f i" "iad")
(def-finn-project-with-branch "f m" "mupf-js")
(def-finn-project-with-branch "f n" "mfinn")
;;(def-finn-project-with-branch "c" "core-js")
(def-finn-project-with-branch "f c " "common-validator-js")
(def-finn-project-with-branch "f a" "analytics-js")

;; (def-finn-project-with-branch "o m" "organisation-management-web")
;; (def-finn-project-with-branch "r u" "realestate-upsale")
;; (def-finn-project-with-branch "s j" "strapon-java-web")
;; (def-finn-project-with-branch "s c" "strapon-core-js")
;; (def-finn-project-with-branch "s w" "strapon-core-web")
;; (def-finn-project-with-branch "s s" "self-service")
;; (def-finn-project-with-branch "s p" "spid-js")


(provide 'finn-projects)
