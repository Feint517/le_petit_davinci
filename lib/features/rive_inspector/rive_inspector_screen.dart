// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import '../../core/constants/assets_manager.dart';
// import 'rive_format_helper.dart';

// class RiveInspectorScreen extends StatefulWidget {
//   const RiveInspectorScreen({super.key});

//   @override
//   State<RiveInspectorScreen> createState() => _RiveInspectorScreenState();
// }

// class _RiveInspectorScreenState extends State<RiveInspectorScreen> {
//   final List<RiveFileInfo> riveFiles = [
//     RiveFileInfo('Boy 1', AnimationAssets.boy1),
//     RiveFileInfo('Boy 2', AnimationAssets.boy2),
//     RiveFileInfo('Girl 1', AnimationAssets.girl1),
//     RiveFileInfo('Girl 2', AnimationAssets.girl2),
//     RiveFileInfo('Games', AnimationAssets.games),
//     RiveFileInfo('Subjects', AnimationAssets.subjects),
//   ];

//   Map<String, List<String>> artboards = {};
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadArtboards();
//   }

//   Future<void> _loadArtboards() async {
//     setState(() {
//       isLoading = true;
//     });

//     // Initialize Rive first
//     try {
//       await RiveFile.initialize();
//     } catch (e) {
//       // If initialization fails, show error for all files
//       for (final fileInfo in riveFiles) {
//         artboards[fileInfo.name] = ['❌ Rive initialization failed: $e'];
//       }
//       setState(() {
//         isLoading = false;
//       });
//       return;
//     }

//     for (final fileInfo in riveFiles) {
//       try {
//         final bytes = await DefaultAssetBundle.of(context).load(fileInfo.path);

//         // Check file extension to determine format
//         final isRevFile = fileInfo.path.endsWith('.rev');
//         final isRivFile = fileInfo.path.endsWith('.riv');

//         if (isRevFile) {
//           // .rev files are binary format - may not be compatible with Flutter Rive package
//           artboards[fileInfo.name] = [
//             '⚠️ .rev file (binary format)',
//             'May not be compatible with Flutter Rive package',
//             'Consider converting to .riv format',
//           ];
//         } else if (isRivFile) {
//           // Try to load .riv files normally
//           try {
//             final file = RiveFile.import(bytes);
//             final artboardNames = <String>[];

//             // Get the main artboard name
//             if (file.mainArtboard != null) {
//               artboardNames.add('Main Artboard: ${file.mainArtboard!.name}');
//             }

//             // Try to get additional artboards
//             // Note: The Rive package may not expose all artboards directly
//             // but we can try to access them through the file structure
//             try {
//               // This is a workaround to try to get artboard names
//               // The exact method may vary depending on the Rive package version
//               artboardNames.add('✅ File loaded successfully');
//               artboardNames.add('📋 Main artboard available');
//             } catch (e) {
//               artboardNames.add('✅ File loaded successfully');
//             }

//             artboards[fileInfo.name] = artboardNames;
//           } catch (e) {
//             artboards[fileInfo.name] = ['❌ Error loading .riv file: $e'];
//           }
//         } else {
//           artboards[fileInfo.name] = ['❓ Unknown file format'];
//         }
//       } catch (e) {
//         artboards[fileInfo.name] = ['❌ Error loading file: $e'];
//       }
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rive Inspector'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.help_outline),
//             onPressed: () => RiveFormatHelper.showFormatInfoDialog(context),
//             tooltip: 'Format Information',
//           ),
//         ],
//       ),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: riveFiles.length,
//                 itemBuilder: (context, index) {
//                   final fileInfo = riveFiles[index];
//                   final artboardNames =
//                       artboards[fileInfo.name] ?? ['No artboards found'];

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             fileInfo.name,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Path: ${fileInfo.path}',
//                             style: const TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           const Text(
//                             'Artboards:',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           ...artboardNames.map(
//                             (name) => Padding(
//                               padding: const EdgeInsets.only(left: 16, top: 4),
//                               child: Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.animation,
//                                     size: 16,
//                                     color: Colors.blue,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     name,
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () => _showPreview(fileInfo),
//                                   child: const Text('Preview'),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   onPressed: () => _showDetailedInfo(fileInfo),
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                     foregroundColor: Colors.white,
//                                   ),
//                                   child: const Text('Inspect'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//     );
//   }

//   void _showPreview(RiveFileInfo fileInfo) {
//     // Check if it's a .rev file and show warning
//     if (fileInfo.path.endsWith('.rev')) {
//       showDialog(
//         context: context,
//         builder:
//             (context) => AlertDialog(
//               title: Text('Preview: ${fileInfo.name}'),
//               content: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.warning, color: Colors.orange, size: 48),
//                   SizedBox(height: 16),
//                   Text(
//                     'This is a .rev file (binary format)',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'The Flutter Rive package may not support .rev files directly. Consider converting to .riv format in the Rive editor.',
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('Close'),
//                 ),
//               ],
//             ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       builder:
//           (context) => Dialog(
//             child: Container(
//               width: 300,
//               height: 400,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Text(
//                     'Preview: ${fileInfo.name}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: FutureBuilder<RiveFile>(
//                       future: _loadRiveFile(fileInfo.path),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.error,
//                                   color: Colors.red,
//                                   size: 48,
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   'Error: ${snapshot.error}',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           );
//                         }

//                         if (snapshot.hasData) {
//                           return RiveAnimation.asset(
//                             fileInfo.path,
//                             fit: BoxFit.contain,
//                           );
//                         }

//                         return const Center(child: Text('No animation found'));
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: const Text('Close'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   void _showDetailedInfo(RiveFileInfo fileInfo) {
//     showDialog(
//       context: context,
//       builder:
//           (context) => Dialog(
//             child: Container(
//               width: 400,
//               height: 500,
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Text(
//                     'Detailed Info: ${fileInfo.name}',
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: FutureBuilder<List<String>>(
//                       future: _getDetailedArtboardInfo(fileInfo.path),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }

//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(
//                                   Icons.error,
//                                   color: Colors.red,
//                                   size: 48,
//                                 ),
//                                 const SizedBox(height: 16),
//                                 Text(
//                                   'Error: ${snapshot.error}',
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ],
//                             ),
//                           );
//                         }

//                         if (snapshot.hasData) {
//                           return SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children:
//                                   snapshot.data!
//                                       .map(
//                                         (info) => Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             vertical: 2,
//                                           ),
//                                           child: Text(
//                                             info,
//                                             style: const TextStyle(
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                       .toList(),
//                             ),
//                           );
//                         }

//                         return const Center(
//                           child: Text('No information available'),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: const Text('Close'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   Future<RiveFile> _loadRiveFile(String path) async {
//     // Ensure Rive is initialized before importing
//     await RiveFile.initialize();
//     final bytes = await DefaultAssetBundle.of(context).load(path);
//     return RiveFile.import(bytes);
//   }

//   Future<List<String>> _getDetailedArtboardInfo(String path) async {
//     try {
//       await RiveFile.initialize();
//       final bytes = await DefaultAssetBundle.of(context).load(path);
//       final file = RiveFile.import(bytes);

//       final info = <String>[];

//       // Get main artboard info
//       if (file.mainArtboard != null) {
//         final artboard = file.mainArtboard!;
//         info.add('🎯 Main Artboard: "${artboard.name}"');
//         info.add('📐 Size: ${artboard.width} x ${artboard.height}');

//         // Quick summary of total artboards
//         try {
//           if (file.artboards != null) {
//             info.add('📊 Total Artboards: ${file.artboards!.length}');
//           }
//         } catch (e) {
//           info.add('📊 Artboard count not accessible');
//         }

//         // Try to get all artboards in the file (not just main)
//         try {
//           // Check if there are multiple artboards
//           info.add('\n📋 All Artboards in File:');

//           // Try to access all artboards
//           // Note: This might not work for all Rive files depending on structure
//           if (file.artboards != null && file.artboards!.isNotEmpty) {
//             info.add('Found ${file.artboards!.length} artboards:');
//             for (int i = 0; i < file.artboards!.length; i++) {
//               final artboard = file.artboards![i];
//               info.add(
//                 '  ${i + 1}. "${artboard.name}" (${artboard.width}x${artboard.height})',
//               );
//             }
//           } else {
//             info.add('Only main artboard available');
//           }
//         } catch (e) {
//           info.add('📋 Artboard list not accessible: $e');
//         }

//         // Try to get animation names
//         try {
//           final animations = artboard.animations;
//           if (animations.isNotEmpty) {
//             info.add('\n🎬 Animations (${animations.length}):');
//             for (final animation in animations) {
//               info.add('  • ${animation.name}');
//             }
//           } else {
//             info.add('\n🎬 No animations found');
//           }
//         } catch (e) {
//           info.add('\n🎬 Animation info not accessible: $e');
//         }

//         // Try to get state machine names
//         try {
//           final stateMachines = artboard.stateMachines;
//           if (stateMachines.isNotEmpty) {
//             info.add('\n🎮 State Machines (${stateMachines.length}):');
//             for (final stateMachine in stateMachines) {
//               info.add('  • ${stateMachine.name}');
//             }
//           } else {
//             info.add('\n🎮 No state machines found');
//           }
//         } catch (e) {
//           info.add('\n🎮 State machine info not accessible: $e');
//         }

//         // Try to get nested artboards or components
//         try {
//           info.add('\n🔍 Searching for nested elements...');

//           // Try to access children or nested artboards
//           if (artboard.children != null && artboard.children!.isNotEmpty) {
//             info.add('Found ${artboard.children!.length} child elements:');
//             for (int i = 0; i < artboard.children!.length; i++) {
//               final child = artboard.children![i];
//               info.add('  • ${child.name} (${child.runtimeType})');
//             }
//           } else {
//             info.add('No child elements found');
//           }
//         } catch (e) {
//           info.add('🔍 Child elements not accessible: $e');
//         }

//         // Try to get all possible elements that could be animated
//         try {
//           info.add('\n🎯 All Possible Animated Elements:');

//           // Look for all nodes in the artboard
//           final allNodes = <String>[];
//           _findAllNodes(artboard, allNodes, '');

//           if (allNodes.isNotEmpty) {
//             info.add('Found ${allNodes.length} elements:');
//             for (final node in allNodes) {
//               info.add('  • $node');
//             }
//           } else {
//             info.add('No individual elements found');
//           }
//         } catch (e) {
//           info.add('🎯 Element search failed: $e');
//         }
//       } else {
//         info.add('❌ No main artboard found');
//       }

//       return info;
//     } catch (e) {
//       return ['❌ Error analyzing file: $e'];
//     }
//   }

//   void _findAllNodes(dynamic node, List<String> nodes, String prefix) {
//     try {
//       if (node == null) return;

//       // Add the current node
//       final nodeName = node.name?.toString() ?? 'unnamed';
//       final nodeType = node.runtimeType.toString();
//       nodes.add('$prefix$nodeName ($nodeType)');

//       // Try to find children
//       try {
//         if (node.children != null) {
//           for (int i = 0; i < node.children.length; i++) {
//             _findAllNodes(node.children[i], nodes, '$prefix  ');
//           }
//         }
//       } catch (e) {
//         // Children not accessible, continue
//       }

//       // Try to find other properties that might contain nodes
//       try {
//         if (node.nodes != null) {
//           for (int i = 0; i < node.nodes.length; i++) {
//             _findAllNodes(node.nodes[i], nodes, '$prefix  ');
//           }
//         }
//       } catch (e) {
//         // Nodes property not accessible, continue
//       }
//     } catch (e) {
//       // Skip this node if there's an error
//     }
//   }
// }

// class RiveFileInfo {
//   final String name;
//   final String path;

//   RiveFileInfo(this.name, this.path);
// }
