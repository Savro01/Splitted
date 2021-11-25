extends Node2D

var colors = ["FD0100", "F76915", "EEDE04", "A0D636", "#f79cee", "333ED4"]

var folders # dossiers dests
var main_pos # dossier source
var dest_pos # dossier dest
var bin # poubelle
	
var filled_folders = []
	
################################# Logic functions ######################
 
## si le fichier est dans le dossier -> change le sprite du dossier
func isOnFolder(file, folder):
	if(file.transform.origin == folder.transform.origin):
		folder.setEmpty(true)
	else:
		folder.setEmpty(false)

func _ready():
	## poubelle
	$bin.setEmpty(true)
	$bin.setToBin()
	
	## dossier source
	main_pos = $mainFolder.transform.origin
	dest_pos = main_pos
	
	# tableau des dossier destination
	folders = get_tree().get_nodes_in_group("dest")
	
	colors.shuffle()
	colors.sort()
	
	for f in range(0, folders.size()):
		if not folders[f].is_in_group("bin"):
			folders[f].setColor(Color(colors[f]))
		
		
func _physics_process(delta):
	# on modifie la position du fichier en fonction des dossiers vides
	# et de la position de la souris
	if $file.selected:
		$mainFolder.setEmpty(true)
		# rend visible le fichier quand on le selectionne
		$file.z_index = 1
		$file.transform.origin = lerp($file.transform.origin, get_local_mouse_position(), 25 * delta)
	else:
		$mainFolder.setEmpty(false)
		# near_folder calcule le dossier le plus proche 
		near_folder()
		$file.transform.origin = lerp($file.transform.origin, dest_pos, 10 * delta)
		# cache le fichier derriere les dossiers
		$file.z_index = -1

func moveFileToPos(pos):
	dest_pos = pos

func near_folder():
		var shortest_dist = 20
		var selectedFolder
		# on calcule la distance avec le fichier le plus proche
		for f in folders:
			var distance = $file.transform.origin.distance_to(f.transform.origin)
			if distance < shortest_dist:
				selectedFolder = f
				shortest_dist = distance
				moveFileToPos(selectedFolder.transform.origin)
				
		if selectedFolder != null:
			# si le fichier est glisse sur un dossier de destination
			if selectedFolder.is_in_group("dest"):
				
				isOnFolder($file, selectedFolder) 	# on met le dossier en mode plein
				# on remet le fichier a la position du dossier source
				$file.transform.origin = $mainFolder.transform.origin
				moveFileToPos(main_pos)
				
				# si le dossier est la poubelle, il est réutilisable
				if not selectedFolder.is_in_group("bin"):
					filled_folders.append(selectedFolder.color.to_html())
					folders.erase(selectedFolder) 		# on supprime le dossier de la liste -> non draggable
