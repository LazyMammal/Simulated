/*
	Run continuously in the Editor.

	Purpose:
		Allows custom shaders to update every frame without going into Play mode.

	Usage:
		"Window" menu, "Runs In Editor".
		Panel must be visible at all times for OnGUI() to trigger.
*/

using System;
using UnityEditor;
using UnityEngine;

public class RunsInEditor : EditorWindow
{
    static private string playButton = "";
    static private bool isRunning = true;

    [MenuItem("Window/Runs In Editor")]
    static void Initialize()
    {
        Type inspectorType = Type.GetType("UnityEditor.InspectorWindow,UnityEditor.dll");
        EditorWindow window = EditorWindow.GetWindow<RunsInEditor>("Runs In Editor", new Type[] { inspectorType });
    }
    void Update()
    {
        if (isRunning && !EditorApplication.isPlaying)
        {
			var scale = Camera.main.transform.localScale;
			scale.x *= 1.0f + 0.0001f * Mathf.Sin((float)EditorApplication.timeSinceStartup * 100.0f);
			Camera.main.transform.localScale = scale;
        }
    }

    void OnGUI()
    {
        EditorGUILayout.Space();
        if (GUILayout.Button(playButton))
        {
            isRunning = !isRunning;
        }
		playButton = isRunning ? "Stop" : "Start";
    }
}
