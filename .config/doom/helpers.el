;;; helpers.el -*- lexical-binding: t; -*-


(defun evil-yank-visible ()
  "Yank only visible text.
If a region is active, yank visible text within that region.
Otherwise, yank all visible text in the buffer."
  (interactive)
  (let* ((start (if (use-region-p) (region-beginning) (point-min)))
         (end   (if (use-region-p) (region-end) (point-max)))
         (text  ""))
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (unless (invisible-p (point))
          (setq text (concat text (buffer-substring-no-properties
                                   (point) (min (1+ (point)) end)))))
        (forward-char)))
    (kill-new text)))

(defvar hd/llm-char-map
  '(("‘" . "'")
    ("’" . "'")
    ("“" . "\"")
    ("”" . "\"")
    ("—" . "--")
    ("–" . "-")
    ("…" . "...")
    ("•" . "-")))

(defun hd/normalize-llm-text (beg end)
  "Normalize Unicode characters using `hd/llm-char-map`."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (list (point-min) (point-max))))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (dolist (pair hd/llm-char-map)
        (goto-char (point-min))
        (while (search-forward (car pair) nil t)
          (replace-match (cdr pair) t t))))))
