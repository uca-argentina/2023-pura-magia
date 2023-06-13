"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoft2Model,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoft2Model class >> ruleBadMessageRule2V1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ShipPosition #fillRedoWith: #false)) #'2023-06-13T00:14:46.289453-03:00') )
]

{ #category : #'code-critics' }
ManifestIngSoft2Model class >> ruleWhileTrueRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#'IngSoft2-Model')) #'2023-06-13T00:14:26.522893-03:00') )
]
