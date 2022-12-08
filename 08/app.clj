(require '[clojure.string :as str])
(require '[clojure.java.io :as io])

(def trees-data-sample [
  [3 0 3 7 3]
  [2 5 5 1 2]
  [6 5 3 3 2]
  [3 3 5 4 9]
  [3 5 3 9 0]]
)

; first is y, second is x
(def left [0 -1])
(def up [-1 0])
(def right [0 1])
(def down [1 0])
(def directions [left up right down])

(defn get-tree [trees pos] (get (get trees (first pos)) (second pos)))
(defn offset [pos dir] [(+ (first pos) (first dir)) (+ (second pos) (second dir))])

(defn visible-dir [trees tree pos dir]
  (let [
    next (offset pos dir)
    ntree (get-tree trees next)
  ]
    (if ntree
      (if (< ntree tree)
        (recur trees tree next dir)
        false
      )
      true
    )
  )
)

(defn scenic-dir [trees tree pos dir score]
  (let [
    next (offset pos dir)
    ntree (get-tree trees next)
  ]
    (if ntree
      (if (< ntree tree)
        (recur trees tree next dir (+ 1 score))
        (+ 1 score)
      )
      score
    )
  )
)

(defn is-visible [trees tree pos] (some (fn [dir] (visible-dir trees tree pos dir)) directions))

(defn scenic-score [trees tree pos] (reduce * (map (fn [dir] (scenic-dir trees tree pos dir 0)) directions)))

(defn iterate-positions [trees iterator]
  (map
    (fn [y]
      (map
        (fn [x] (iterator [y x]))
        (range 0 (count (get trees y)))
      )
    )
    (range 0 (count trees))
  )
)

(defn collect [trees collector]
  (remove nil? (apply concat
    (iterate-positions trees (fn [pos] (collector pos (get-tree trees pos))))
  ))
)

(defn collect-visible [trees] (collect trees (fn [pos tree] (if (is-visible trees tree pos) pos nil))))

(defn collect-scenic [trees] (collect trees (fn [pos tree] (scenic-score trees tree pos))))

(defn num-of-visible [trees] (count (collect-visible trees)))

(defn best-scenic [trees] (reduce max (collect-scenic trees)))

(defn main []
  (with-open [rdr (io/reader "data")]
    (let [
      lines (line-seq rdr)
      parsed (map (fn [line] (map (fn [tree] (Integer/parseInt (str tree))) line)) lines)
      trees (vec (map vec (doall parsed)))
    ]
      (println (str "1: " (num-of-visible trees) " 2: " (best-scenic trees)))
    )
  )
)
(main)

