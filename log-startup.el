(add-to-list 'load-path "/home/tassos/software/emacs-odbc")

(require 'emacs-odbc)

(defvar log-startup-connection-string "DSN=MariaDBTest; UID=tassos; PWD=123"
  "ODBC connection string for database to store start up events.")

;; "CREATE TABLE Events (
;;     EventID int NOT NULL,
;;     EventDate DATETIME,
;;     PRIMARY KEY (EventID)
;; );"

(defun log-startup ()
  "Log start up in a local database via ODBC."

  (let* ((env-handle (odbc-alloc-env))
         (dbc-handle (odbc-alloc-dbc env-handle)))
    (odbc-connect dbc-handle)
    (let ((stmt-handle (odbc-alloc-stmt dbc-handle)))
      (odbc-exec-direct stmt-handle "INSERT INTO Events (EventID, EventDate) VALUES (1, NOW());"))))

(add-hook 'emacs-startup-hook 'log-startup)

(provide 'log-startup)
