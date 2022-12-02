<?php

namespace App\Controller;
use App\Entity\Post;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PostController extends AbstractController
{
    private $em;
    /**
     *  @param $em
     */

    public function __construct(EntityManagerInterface $em) 
    {
        $this->em = $em;
    }

    #[Route('/post/{id}' , name: 'app_post')]
    public function index($id): Response
    {
        $posts = $this->em->getRepository(Post::class)->findAll($id);
        return $this->render('post/index.html.twig', [
            'posts' => $posts,
        ]);
    }
}
