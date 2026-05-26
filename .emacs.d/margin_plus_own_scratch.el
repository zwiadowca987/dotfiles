;; Marginesy Boczne (10 %)
;; Funkcja:
;; - Oblicza margines = 10% szerokości okna (max 20 kolumn)
;; - Ustawia marginesy po obu stronach tekstu
(defun my/set-margins (&rest _)
  (let* ((win (selected-window))
         (w (window-total-width win))
         ;; zachowaj rozsądek: max 20 kolumn
         (m (min 20 (/ w 10))))
    (set-window-margins win m m)))
;; Włącza marginesy przy starcie i zmianie rozmiaru okna
(add-hook 'window-size-change-functions #'my/set-margins)
(add-hook 'emacs-startup-hook #'my/set-margins)

;; =======================================================================
;; SMART SCRATCH (zamiast dashboard) + pełny ekran
;; =======================================================================

(setq inhibit-startup-screen t)
(setq initial-buffer-choice nil)

(defvar my/scratch-last-mode 'org-mode
  "Ostatnio użyty tryb w scratch.")

(defun my/scratch-select-mode ()
  "Zapytaj o tryb scratcha z domyślną ostatnią wartością."
  (intern
   (completing-read
    (format "Scratch mode (default %s): " my/scratch-last-mode)
    '("org-mode" "markdown-mode" "text-mode")
    nil t nil nil
    (symbol-name my/scratch-last-mode))))

(defun my/open-scratch ()
  "Otwórz lub przełącz na bufor *scratch* z wybranym trybem i maksymalizacją."
  (interactive)
  (let ((mode (my/scratch-select-mode)))
    (setq my/scratch-last-mode mode)
    ;; Utwórz/przełącz bufor scratch
    (switch-to-buffer (get-buffer-create "*scratch*"))
    ;; Maksymalizuj ramkę jeśli GUI
    (when (display-graphic-p)
      (toggle-frame-maximized (selected-frame)))
    ;; Ustaw tryb
    (funcall mode)
    ;; Pozwól na zapis, jeśli trzeba
    (setq-local buffer-offer-save t)))

(defun my/show-scratch-on-startup ()
  "Pokaż scratch tylko jeśli Emacs startuje bez pliku i bez dired."
  (when (and (not (buffer-file-name))
             (not (derived-mode-p 'dired-mode))
             (= (length command-line-args-left) 0))
    (my/open-scratch)))

;; Scratch przy starcie
(add-hook 'emacs-startup-hook #'my/show-scratch-on-startup)

;; Skrót do zmiany trybu scratcha w trakcie pracy
(global-set-key (kbd "C-c s") #'my/open-scratch)

;; Maksymalizacja każdej nowej ramki GUI
(defun my/maximize-frame-if-gui (frame)
  "Maksymalizuje ramkę jeśli jest graficzna."
  (when (display-graphic-p frame)
    (toggle-frame-maximized frame)))

(add-hook 'after-make-frame-functions #'my/maximize-frame-if-gui)
