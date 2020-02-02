INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('cannabis', 'Weed Buds', 42, 0, 1),
	('marijuana', 'Weed Pouch', 14, 0, 1),
	('opium', 'Opium Extract', 42, 0, 1),
	('heroin', 'Heroin Pouch', 14, 0, 1),
	('meth', 'Methylamine', 14, 0, 1),
	('meth2', 'Phenylacetic acid', 14, 0, 1),
	('meth3', 'Pseudoephedrine', 14, 0, 1),
	('crystal', 'Crystal Meth', 14, 0, 1),
	('coca', 'Coca Leafs', 126, 0, 1),
	('cocaine', 'Coke Pouch', 14, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('weed_processing', 'Weed Processing License'),
	('opium_processing', 'Opium Processing License'),
	('meth_processing', 'Meth Processing License'),
	('coca_processing', 'Cocaine Processing License')
;