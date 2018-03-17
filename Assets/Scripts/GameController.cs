using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameController : MonoBehaviour
{
    public float planetRadius = 22.5f;
    public int propertyID = 334;
    public string propertyName = "_PlanetRadius";
    public float minRadius = 10f;
    public float growFactor = 1.5f;

    void Start()
    {
        propertyID = Shader.PropertyToID(propertyName);

        //Shader.SetGlobalFloat(propertyID, planetRadius);

        Camera.main.cullingMatrix = new Matrix4x4(Vector4.zero, Vector4.zero,
                                    new Vector4(0.0f, 0.0f, 1.0f, 1.0f), new Vector4(0.0f, 0.0f, -0.6f, 0.0f));
		/*
        Debug.Log("FoV: " + Camera.main.fieldOfView + "\n" +
                "Scale: " + Camera.main.transform.localScale + "\n" +
                Camera.main.cullingMatrix.GetColumn(0) + "\n" +
                Camera.main.cullingMatrix.GetColumn(1) + "\n" +
                Camera.main.cullingMatrix.GetColumn(2) + "\n" +
                Camera.main.cullingMatrix.GetColumn(3));
		 */
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Equals) || Input.GetKeyDown(KeyCode.KeypadPlus))
        {
            planetRadius *= growFactor;
            planetRadius = Mathf.Max(minRadius, planetRadius);
            //Shader.SetGlobalFloat(propertyID, planetRadius);
        }
        if (Input.GetKeyDown(KeyCode.Minus) || Input.GetKeyDown(KeyCode.KeypadMinus))
        {
            planetRadius /= growFactor;
            planetRadius = Mathf.Max(minRadius, planetRadius);
            //Shader.SetGlobalFloat(propertyID, planetRadius);
        }
    }
}
