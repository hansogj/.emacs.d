(defun setup-find-file-in-project ()
  (ffip-local-excludes "target" "overlays" "node_modules" "grunt_temp")
  (ffip-local-patterns "*.js" "*.java" "*.jsp" "*.mustache" "*.css" "tiles*.xml" "pom.xml"))

(defun custom-persp/eika-ahv-nettbank ()
  (interactive)
  (custom-persp "eika-ahv-nettbank"
                (set-background-color poisonGreen)
                (find-file "/git/eika/antihvitvask-nettbank/web/src/angular-app/")))
(project-specifics "/git/eika/antihvitvask-nettbank/web/src/angular-app/")


(defun custom-persp/eika-ahv ()
  (interactive)
  (custom-persp "eika-ahv"
                (set-background-color dreadfullRed)
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
                (find-file "/git/eika/bli_kunde/nettbank/web/src/angular-app/")
                (set-background-color kindOfBlue)))
(project-specifics "/git/eika/bli_kunde/nettbank/web/src/angular-app/"
  (setup-find-file-in-project))


(defun custom-persp/eika-erklaring ()
  (interactive)
  (custom-persp "eika-eika-erklaring"
                (find-file "/git/eika/antihvitvask-erklaering-angularjs-lib/")
                (set-background-color  "gray20")))
(project-specifics "/git/eika/antihvitvask-erklaering-angularjs-lib/")


(define-key persp-mode-map (kbd "C-x p e e") 'custom-persp/eika-erklaring)
(define-key persp-mode-map (kbd "C-x p e b") 'custom-persp/bli_kunde)
(define-key persp-mode-map (kbd "C-x p e a") 'custom-persp/eika-ahv)
(define-key persp-mode-map (kbd "C-x p e n") 'custom-persp/eika-ahv-nettbank)
(define-key persp-mode-map (kbd "C-x p e r") 'custom-persp/eika-raadgiverportal_boostrap-lib)


(provide 'eika-projects)
