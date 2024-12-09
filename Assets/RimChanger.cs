using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RimChanger : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Z))
        {
            GetComponent<Renderer>().material.SetColor("_RimColor", Color.red);
        }
        if (Input.GetKeyDown(KeyCode.X))
        {
            GetComponent<Renderer>().material.SetColor("_RimColor", Color.black);
        }
    }

  //  private IEnumerator FlashColor(GameObject hit)
    //{
    //    hit.GetComponent<Renderer>().material.SetColor("_RimColor", Color.white);
  //      yield return new WaitForSeconds(0.1f);
   //     hit.GetComponent<Renderer>().material.SetColor("_RimColor", new Color32(128,0,0,0));
  //  }
}
